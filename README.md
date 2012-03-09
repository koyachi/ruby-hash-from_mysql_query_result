# hash-from_mysql_query_result

Create Hash from MySQL query result text.

## Example

```ruby
data = Hash::FromMysqlQueryResult.parse_text(DATA.lines.to_a.join(""))
pp data
# => {:header=>["mysql> SELECT * FROM foo;"],
#     :fields=>["id", "value"],
#     :records=>
#      [{"id"=>"1", "value"=>"A"},
#       {"id"=>"2", "value"=>"b"},
#       {"id"=>"3", "value"=>"C"}],
#     :footer=>["3 rows in set (0.01 sec)"]}

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

```

## License

Released under the MIT License - Copyright (c) 2012 koyachi
