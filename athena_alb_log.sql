CREATE EXTERNAL TABLE `alb_logs_alb-dataservice-api-legacy`(
  `type` string COMMENT '', 
  `time` string COMMENT '', 
  `elb` string COMMENT '', 
  `client_ip` string COMMENT '', 
  `client_port` int COMMENT '', 
  `target_ip` string COMMENT '', 
  `target_port` int COMMENT '', 
  `request_processing_time` double COMMENT '', 
  `target_processing_time` double COMMENT '', 
  `response_processing_time` double COMMENT '', 
  `elb_status_code` string COMMENT '', 
  `target_status_code` string COMMENT '', 
  `received_bytes` bigint COMMENT '', 
  `sent_bytes` bigint COMMENT '', 
  `request_verb` string COMMENT '', 
  `request_url` string COMMENT '', 
  `request_proto` string COMMENT '', 
  `user_agent` string COMMENT '', 
  `ssl_cipher` string COMMENT '', 
  `ssl_protocol` string COMMENT '', 
  `target_group_arn` string COMMENT '', 
  `trace_id` string COMMENT '', 
  `domain_name` string COMMENT '', 
  `chosen_cert_arn` string COMMENT '', 
  `matched_rule_priority` string COMMENT '', 
  `request_creation_time` string COMMENT '', 
  `actions_executed` string COMMENT '', 
  `redirect_url` string COMMENT '', 
  `lambda_error_reason` string COMMENT '', 
  `target_port_list` string COMMENT '', 
  `target_status_code_list` string COMMENT '', 
  `new_field` string COMMENT '')
PARTITIONED BY ( 
  `year` int, 
  `month` int, 
  `day` int)
ROW FORMAT SERDE 
  'org.apache.hadoop.hive.serde2.RegexSerDe' 
WITH SERDEPROPERTIES ( 
  'input.regex'='([^ ]*) ([^ ]*) ([^ ]*) ([^ ]*):([0-9]*) ([^ ]*)[:-]([0-9]*) ([-.0-9]*) ([-.0-9]*) ([-.0-9]*) (|[-0-9]*) (-|[-0-9]*) ([-0-9]*) ([-0-9]*) \"([^ ]*) ([^ ]*) (- |[^ ]*)\" \"([^\"]*)\" ([A-Z0-9-]+) ([A-Za-z0-9.-]*) ([^ ]*) \"([^\"]*)\" \"([^\"]*)\" \"([^\"]*)\" ([-.0-9]*) ([^ ]*) \"([^\"]*)\" \"([^\"]*)\" \"([^ ]*)\" \"([^\"]+)\" \"([^\"]+)\"(.*)') 
STORED AS INPUTFORMAT 
  'org.apache.hadoop.mapred.TextInputFormat' 
OUTPUTFORMAT 
  'org.apache.hadoop.hive.ql.io.HiveIgnoreKeyTextOutputFormat'
LOCATION
  's3://dev-data-service-alb-logs/AWSLogs/622603323723/elasticloadbalancing/ap-southeast-2'
TBLPROPERTIES (
  'compressionType'='gzip', 
  'projection.day.digits'='2', 
  'projection.day.range'='1,31', 
  'projection.day.type'='integer', 
  'projection.enabled'='true', 
  'projection.month.digits'='2', 
  'projection.month.range'='1,12', 
  'projection.month.type'='integer', 
  'projection.year.range'='2010,2032', 
  'projection.year.type'='integer', 
  'storage.location.template'='s3://dev-data-service-alb-logs/AWSLogs/622603323723/elasticloadbalancing/ap-southeast-2/${year}/${month}/${day}/', 
  'transient_lastDdlTime'='1657623741')

SELECT client_ip,count(*) as total_count FROM "dealer_transaction"."alb_logs_alb-dataservice-api-legacy"  group by client_ip order by total_count desc;
