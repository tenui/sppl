ENV["WATCHR"] = "1"

def run(cmd)
  puts "--  " * 10
  puts(cmd)
  system cmd
end

def run_test_file(file)
  run(%Q(ruby -I"lib:test" -rubygems #{file}))
end

def run_unit_test(file)
  run(%Q(rake test:units TEST=#{file}))
end

#def run_integration_tests
#  run(%Q(rake test:integration))
#end

def run_functional_test(file)
  run(%Q(rake test:functional TEST=#{file}))
end

def run_all_tests
  run "rake test"
end

def run_all_features
  run "rake cucumber"
end

def related_test_files(path)
  Dir['test/**/*.rb'].select { |file| file =~ /#{File.basename(path).split(".").first}_test.rb/ }
end

def run_suite
  run_all_tests
  # run_all_features
end

watch('test/test_helper\.rb') { run_all_tests }
watch('test/.*/.*_test\.rb') { |m| run_test_file(m[0]) }
#watch('app/model/.*\.rb') { |m| related_test_files(m[1]).map {|tf| run_test_file(tf) } }
watch('app/.*/.*\.rb') { |m| related_test_files(m[0]).map {|tf| run_test_file(tf) } }
watch('features/.*/.*\.feature') { run_all_features }

# Ctrl-\
Signal.trap 'QUIT' do
  puts " --- Running all tests ---\n\n"
  run_suite
end

@interrupted = false

# Ctrl-C
Signal.trap 'INT' do
  if @interrupted then
    abort("\n")
  else
    puts "Interrupt a second time to quit"
    @interrupted = true
    Kernel.sleep 1.5
    @interrupted = false
    # raise Interrupt, nil # let the run loop catch it
    run_suite
  end
end
