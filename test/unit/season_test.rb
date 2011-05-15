require 'test_helper'

class SeasonTest < ActiveSupport::TestCase

  should have_db_column :ordinal
  should have_db_column :start_year
  should have_db_column :stop_year

  should have_many :matches

  should "have a name method" do
    assert_respond_to Season.new, :name
  end
  
end
