# 表名结尾加$表示生成为更新脚本
# 更新条件为$之后指定，如id，则更新条件为id=@id的情况，如果多条件，则用通过完整的where语句
# 如id=@id AND name=@name AND tenant_id=123666
# 其中直接使用参数，则@id,@name等等，具体值，则直接写常量
# 更新的列中如果不需要更新，而只是为了查询出条件项，而不需要作为更新列，则指定为"列名?"
# 如主键id不需要更新，则id?
# 导出相关人数据资源表配置
[relevant_personnel_table_config;is_deleted=0 ORDER BY system_id]
id
table_name,string
system_id
db_type
order_type
status
primary_column_name,string
temporary_name,string
creator_id
creator_name,string
creation_time
last_modifier_id
last_modifier_name,string
last_modification_time
is_deleted
deleter_id
deleter_name,string
deletion_time

# 相关人数据资源表配置项
[relevant_personnel_table_config_item;is_deleted=0 ORDER BY system_id,table_config_id,id]
id
system_id
table_config_id
table_name,string
column_name,string
additional_condition,string
creator_id
creator_name,string
creation_time
last_modifier_id
last_modifier_name,string
last_modification_time
is_deleted
deleter_id
deleter_name,string
deletion_time

# 组合结果配置
# 只针对insert生效，条件中各列数据必须在以对应的表中配置项中存在
# 关键字，固定“merge”，如果需要备注，则在其后","设置备注内容或设置备注对应的主表字段table_name.column进行设置
# 组合关系是：relevant_personnel_table_config.id=relevant_personnel_table_config_item.table_config_id
# 结果为：一行主表sql，随后附加一系列明细表的sql
[merge,relevant_personnel_table_config.table_name]
relevant_personnel_table_config,id
relevant_personnel_table_config_item,table_config_id