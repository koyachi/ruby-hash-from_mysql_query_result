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

## Output ruby-hash or json by command line

```
% q2h ./spec/fixtures/describe_pet.txt -o json
{"header":["mysql> DESCRIBE pet;"],"fields":["Field","Type","Null","Key","Default","Extra"],"records":[{"Field":"name","Type":"varchar(20)","Null":"YES","Key":"","Default":"NULL","Extra":""},{"Field":"owner","Type":"varchar(20)","Null":"YES","Key":"","Default":"NULL","Extra":""},{"Field":"species","Type":"varchar(20)","Null":"YES","Key":"","Default":"NULL","Extra":""},{"Field":"sex","Type":"char(1)","Null":"YES","Key":"","Default":"NULL","Extra":""},{"Field":"birth","Type":"date","Null":"YES","Key":"","Default":"NULL","Extra":""},{"Field":"death","Type":"date","Null":"YES","Key":"","Default":"NULL","Extra":""}],"footer":[]}
```


## License

Released under the MIT License - Copyright (c) 2012 koyachi
