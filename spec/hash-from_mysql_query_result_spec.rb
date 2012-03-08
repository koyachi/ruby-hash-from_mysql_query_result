# -*- coding: utf-8 -*-
$:.unshift File.dirname(__FILE__)

require 'hash-from_mysql_query_result'

describe Hash::FromMysqlQueryResult do
  before do
    @text = DATA.lines.to_a.join("")
  end

  it 'should parse_text' do
    result = parse_text(@text)
    result.should eql({
        :header=>["mysql> SELECT * FROM foo;"],
        :fields=>["id", "value"],
        :records=>
        [{"id"=>"1", "value"=>"A"},
          {"id"=>"2", "value"=>"b"},
          {"id"=>"3", "value"=>"C"}],
        :footer=>["3 rows in set (0.01 sec)"]})
  end
end

__END__
mysql> SELECT * FROM foo;
+----+-------+
| id | value |
+----+-------+
|  1 |     A |
|  2 |     b |
|  3 |     C |
+----+-------+
3 rows in set (0.01 sec)
