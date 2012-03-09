# -*- coding: utf-8 -*-
$:.unshift File.dirname(__FILE__)

require 'hash-from_mysql_query_result'
require 'pp'

describe Hash::FromMysqlQueryResult do
  def fixture(filename)
    File.dirname(__FILE__) + '/fixtures/' + filename
  end

  before do
    data = <<-TEST_DATA
mysql> SELECT * FROM foo;
+----+-------+
| id | value |
+----+-------+
|  1 |     A |
|  2 |     b |
|  3 |       |
+----+-------+
3 rows in set (0.01 sec)
TEST_DATA

    @text = data.lines.to_a.join("")
  end

  it 'should parse_text' do
    result = Hash::FromMysqlQueryResult.parse_text(@text)
    result.should eql({
        :header => ["mysql> SELECT * FROM foo;"],
        :fields => ["id", "value"],
        :records => [
          {"id" => "1", "value" => "A"},
          {"id" => "2", "value" => "b"},
          {"id" => "3", "value" => ""}
        ],
        :footer => ["3 rows in set (0.01 sec)"]
      })
  end

  it 'should process_file' do
    result = Hash::FromMysqlQueryResult.process_file(fixture("describe_pet.txt"))
    result.should eql({
        :header => ["mysql> DESCRIBE pet;"],
        :fields => ["Field", "Type", "Null", "Key", "Default", "Extra"],
        :records => [
          {"Field" => "name", "Type" => "varchar(20)", "Null" => "YES", "Key" => "", "Default" => "NULL", "Extra" => ""},
          {"Field" => "owner", "Type" => "varchar(20)", "Null" => "YES", "Key" => "", "Default" => "NULL", "Extra" => ""},
          {"Field" => "species", "Type" => "varchar(20)", "Null" => "YES", "Key" => "", "Default" => "NULL", "Extra" => ""},
          {"Field" => "sex", "Type" => "char(1)", "Null" => "YES", "Key" => "", "Default" => "NULL", "Extra" => ""},
          {"Field" => "birth", "Type" => "date", "Null" => "YES", "Key" => "", "Default" => "NULL", "Extra" => ""},
          {"Field" => "death", "Type" => "date", "Null" => "YES", "Key" => "", "Default" => "NULL", "Extra" => ""},
        ],
        :footer => []
      })
  end
end

