-- This resolves the potential performance issue in #170.  These values are 
--   calculated as Tasks and Task Logs are updated instead of calculated at 
--   run time.

UPDATE projects SET project_task_count = (
	SELECT COUNT(*) FROM tasks WHERE task_project = project_id
);

-- This sets up the ability to call the hook_cron to clear old or null user sessions.

UPDATE modules SET mod_main_class = 'CUser' WHERE mod_directory = 'admin';

-- This adds some columns that are now being used.  For new installations, 
--   they were in place.  For conversions from dotProject, not necessarily.

ALTER TABLE `projects` ADD `project_created` DATETIME NOT NULL default '1000-01-01 00:00:00';
ALTER TABLE `projects` ADD `project_updated` DATETIME NOT NULL default '1000-01-01 00:00:00';
ALTER TABLE `projects` ADD `project_status_comment` VARCHAR(255) NOT NULL default '';
ALTER TABLE `projects` ADD `project_subpriority` TINYINT(4) NOT NULL default 0;
ALTER TABLE `projects` ADD `project_end_date_adjusted` DATETIME NOT NULL default '1000-01-01 00:00:00';
ALTER TABLE `projects` ADD `project_end_date_adjusted_user` INT(10) NOT NULL default 0;

-- Remove all the old indexes

ALTER TABLE `billingcode` DROP INDEX `billingcode_name`;
ALTER TABLE `billingcode` DROP INDEX `billingcode_status`;
ALTER TABLE `companies` DROP INDEX `company_name`;
ALTER TABLE `companies` DROP INDEX `company_type`;
ALTER TABLE `companies` DROP INDEX `company_owner`;
ALTER TABLE `config` DROP INDEX `config_name`;
ALTER TABLE `config_list` DROP INDEX `config_id`;
ALTER TABLE `contacts` DROP INDEX `contact_department`;
ALTER TABLE `contacts` DROP INDEX `contact_email`;
ALTER TABLE `contacts` DROP INDEX `contact_last_name`;
ALTER TABLE `contacts` DROP INDEX `idx_prp`;
ALTER TABLE `contacts` DROP INDEX `idx_oby`;
ALTER TABLE `contacts` DROP INDEX `contact_private`;
ALTER TABLE `contacts` DROP INDEX `contact_updatekey`;
ALTER TABLE `contacts` DROP INDEX `contact_first_name`;
ALTER TABLE `contacts` DROP INDEX `idx_co`;
ALTER TABLE `custom_fields_lists` DROP INDEX `list_option_id`;
ALTER TABLE `custom_fields_lists` DROP INDEX `field_id`;
ALTER TABLE `custom_fields_struct` DROP INDEX `field_page`;
ALTER TABLE `custom_fields_struct` DROP INDEX `field_order`;
ALTER TABLE `custom_fields_struct` DROP INDEX `field_module`;
ALTER TABLE `custom_fields_values` DROP INDEX `value_field_id`;
ALTER TABLE `custom_fields_values` DROP INDEX `value_object_id`;
ALTER TABLE `departments` DROP INDEX `dept_type`;
ALTER TABLE `departments` DROP INDEX `dept_owner`;
ALTER TABLE `departments` DROP INDEX `dept_parent`;
ALTER TABLE `departments` DROP INDEX `dept_name`;
ALTER TABLE `departments` DROP INDEX `dept_company`;
ALTER TABLE `events` DROP INDEX `event_project`;
ALTER TABLE `events` DROP INDEX `event_parent`;
ALTER TABLE `events` DROP INDEX `event_start_date`;
ALTER TABLE `events` DROP INDEX `event_type`;
ALTER TABLE `events` DROP INDEX `event_owner`;
ALTER TABLE `events` DROP INDEX `event_end_date`;
ALTER TABLE `event_queue` DROP INDEX `queue_type`;
ALTER TABLE `event_queue` DROP INDEX `queue_start`;
ALTER TABLE `event_queue` DROP INDEX `queue_origin_id`;
ALTER TABLE `event_queue` DROP INDEX `queue_module`;
ALTER TABLE `files` DROP INDEX `file_owner`;
ALTER TABLE `files` DROP INDEX `file_parent`;
ALTER TABLE `files` DROP INDEX `file_project`;
ALTER TABLE `files` DROP INDEX `file_name`;
ALTER TABLE `files` DROP INDEX `file_category`;
ALTER TABLE `files` DROP INDEX `file_type`;
ALTER TABLE `files` DROP INDEX `file_task`;
ALTER TABLE `files` DROP INDEX `file_folder`;
ALTER TABLE `files_index` DROP INDEX `idx_fwrd`;
ALTER TABLE `file_folders` DROP INDEX `file_folder_name`;
ALTER TABLE `file_folders` DROP INDEX `file_folder_parent`;
ALTER TABLE `forums` DROP INDEX `forum_name`;
ALTER TABLE `forums` DROP INDEX `idx_fowner`;
ALTER TABLE `forums` DROP INDEX `forum_status`;
ALTER TABLE `forums` DROP INDEX `idx_fproject`;
ALTER TABLE `forum_messages` DROP INDEX `idx_mforum`;
ALTER TABLE `forum_messages` DROP INDEX `idx_mparent`;
ALTER TABLE `forum_messages` DROP INDEX `message_author`;
ALTER TABLE `forum_messages` DROP INDEX `idx_mdate`;
ALTER TABLE `forum_visits` DROP INDEX `idx_fv`;
ALTER TABLE `forum_watch` DROP INDEX `idx_fw1`;
ALTER TABLE `forum_watch` DROP INDEX `idx_fw2`;
ALTER TABLE `gacl_acl` DROP INDEX `gacl_updated_date_acl`;
ALTER TABLE `gacl_acl` DROP INDEX `gacl_enabled_acl`;
ALTER TABLE `gacl_acl` DROP INDEX `gacl_section_value_acl`;
ALTER TABLE `gacl_acl_sections` DROP INDEX `gacl_value_acl_sections`;
ALTER TABLE `gacl_acl_sections` DROP INDEX `gacl_hidden_acl_sections`;
ALTER TABLE `gacl_aco` DROP INDEX `gacl_hidden_aco`;
ALTER TABLE `gacl_aco` DROP INDEX `gacl_section_value_value_aco`;
ALTER TABLE `gacl_aco_sections` DROP INDEX `gacl_hidden_aco_sections`;
ALTER TABLE `gacl_aco_sections` DROP INDEX `gacl_value_aco_sections`;
ALTER TABLE `gacl_aro` DROP INDEX `gacl_hidden_aro`;
ALTER TABLE `gacl_aro` DROP INDEX `gacl_section_value_value_aro`;
ALTER TABLE `gacl_aro_groups` DROP INDEX `gacl_value_aro_groups`;
ALTER TABLE `gacl_aro_groups` DROP INDEX `gacl_lft_rgt_aro_groups`;
ALTER TABLE `gacl_aro_groups` DROP INDEX `gacl_parent_id_aro_groups`;
ALTER TABLE `gacl_aro_sections` DROP INDEX `gacl_value_aro_sections`;
ALTER TABLE `gacl_aro_sections` DROP INDEX `gacl_hidden_aro_sections`;
ALTER TABLE `gacl_axo` DROP INDEX `gacl_hidden_axo`;
ALTER TABLE `gacl_axo` DROP INDEX `gacl_section_value_value_axo`;
ALTER TABLE `gacl_axo_groups` DROP INDEX `gacl_parent_id_axo_groups`;
ALTER TABLE `gacl_axo_groups` DROP INDEX `gacl_lft_rgt_axo_groups`;
ALTER TABLE `gacl_axo_groups` DROP INDEX `gacl_value_axo_groups`;
ALTER TABLE `gacl_axo_sections` DROP INDEX `gacl_hidden_axo_sections`;
ALTER TABLE `gacl_axo_sections` DROP INDEX `gacl_value_axo_sections`;
ALTER TABLE `gacl_permissions` DROP INDEX `user_name`;
ALTER TABLE `gacl_permissions` DROP INDEX `item_id`;
ALTER TABLE `gacl_permissions` DROP INDEX `user_id`;
ALTER TABLE `gacl_permissions` DROP INDEX `action`;
ALTER TABLE `gacl_permissions` DROP INDEX `acl_id`;
ALTER TABLE `gacl_permissions` DROP INDEX `module`;
ALTER TABLE `links` DROP INDEX `idx_link_parent`;
ALTER TABLE `links` DROP INDEX `idx_link_task`;
ALTER TABLE `links` DROP INDEX `idx_link_project`;
ALTER TABLE `modules` DROP INDEX `mod_directory`;
ALTER TABLE `modules` DROP INDEX `mod_ui_order`;
ALTER TABLE `modules` DROP INDEX `permissions_item_table`;
ALTER TABLE `modules` DROP INDEX `mod_active`;
ALTER TABLE `projects` DROP INDEX `idx_sdate`;
ALTER TABLE `projects` DROP INDEX `project_type`;
ALTER TABLE `projects` DROP INDEX `project_parent`;
ALTER TABLE `projects` DROP INDEX `project_company`;
ALTER TABLE `projects` DROP INDEX `idx_edate`;
ALTER TABLE `projects` DROP INDEX `project_original_parent`;
ALTER TABLE `projects` DROP INDEX `project_status`;
ALTER TABLE `projects` DROP INDEX `project_name`;
ALTER TABLE `projects` DROP INDEX `project_short_name`;
ALTER TABLE `project_contacts` DROP INDEX `project_id`;
ALTER TABLE `project_contacts` DROP INDEX `contact_id`;
ALTER TABLE `project_departments` DROP INDEX `project_id`;
ALTER TABLE `project_departments` DROP INDEX `department_id`;
ALTER TABLE `sessions` DROP INDEX `session_created`;
ALTER TABLE `sessions` DROP INDEX `session_user`;
ALTER TABLE `sessions` DROP INDEX `session_updated`;
ALTER TABLE `syskeys` DROP INDEX `syskey_name`;
ALTER TABLE `sysvals` DROP INDEX `sysval_key_id`;
ALTER TABLE `sysvals` DROP INDEX `sysval_value_id`;
ALTER TABLE `sysvals` DROP INDEX `sysval_title`;
ALTER TABLE `tasks` DROP INDEX `task_priority`;
ALTER TABLE `tasks` DROP INDEX `task_start_date`;
ALTER TABLE `tasks` DROP INDEX `idx_task_owner`;
ALTER TABLE `tasks` DROP INDEX `idx_task_parent`;
ALTER TABLE `tasks` DROP INDEX `task_percent_complete`;
ALTER TABLE `tasks` DROP INDEX `task_name`;
ALTER TABLE `tasks` DROP INDEX `task_end_date`;
ALTER TABLE `tasks` DROP INDEX `idx_task_order`;
ALTER TABLE `tasks` DROP INDEX `idx_task_project`;
ALTER TABLE `tasks` DROP INDEX `task_creator`;
ALTER TABLE `tasks` DROP INDEX `task_status`;
ALTER TABLE `tasks_critical` DROP INDEX `task_project`;
ALTER TABLE `tasks_problems` DROP INDEX `task_project`;
ALTER TABLE `tasks_sum` DROP INDEX `task_project`;
ALTER TABLE `tasks_summy` DROP INDEX `task_project`;
ALTER TABLE `tasks_total` DROP INDEX `task_project`;
ALTER TABLE `tasks_users` DROP INDEX `task_project`;
ALTER TABLE `task_contacts` DROP INDEX `contact_id`;
ALTER TABLE `task_contacts` DROP INDEX `task_id`;
ALTER TABLE `task_departments` DROP INDEX `department_id`;
ALTER TABLE `task_departments` DROP INDEX `task_id`;
ALTER TABLE `task_log` DROP INDEX `task_log_creator`;
ALTER TABLE `task_log` DROP INDEX `idx_log_task`;
ALTER TABLE `task_log` DROP INDEX `task_log_costcode`;
ALTER TABLE `task_log` DROP INDEX `task_log_date`;
ALTER TABLE `task_log` DROP INDEX `task_log_problem`;
ALTER TABLE `users` DROP INDEX `user_contact`;
ALTER TABLE `users` DROP INDEX `idx_pwd`;
ALTER TABLE `users` DROP INDEX `idx_uid`;
ALTER TABLE `user_access_log` DROP INDEX `date_time_out`;
ALTER TABLE `user_access_log` DROP INDEX `date_time_last_action`;
ALTER TABLE `user_access_log` DROP INDEX `date_time_in`;
ALTER TABLE `user_events` DROP INDEX `uek1`;
ALTER TABLE `user_events` DROP INDEX `uek2`;
ALTER TABLE `user_feeds` DROP INDEX `feed_token`;
ALTER TABLE `user_preferences` DROP INDEX `pref_user`;
ALTER TABLE `user_tasks` DROP INDEX `perc_assignment`;
ALTER TABLE `user_tasks` DROP INDEX `user_id`;
ALTER TABLE `user_task_pin` DROP INDEX `task_id`;

-- Add the correct indexes

ALTER TABLE `billingcode` ADD INDEX (`billingcode_name`);
ALTER TABLE `billingcode` ADD INDEX (`billingcode_status`);
ALTER TABLE `companies` ADD INDEX (`company_name`);
ALTER TABLE `companies` ADD INDEX (`company_type`);
ALTER TABLE `companies` ADD INDEX (`company_owner`);
ALTER TABLE `config` ADD INDEX (`config_name`);
ALTER TABLE `config_list` ADD INDEX (`config_id`);
ALTER TABLE `contacts` ADD INDEX (`contact_first_name`);
ALTER TABLE `contacts` ADD INDEX (`contact_last_name`);
ALTER TABLE `contacts` ADD INDEX (`contact_company`);
ALTER TABLE `contacts` ADD INDEX (`contact_department`);
ALTER TABLE `contacts` ADD INDEX (`contact_email`);
ALTER TABLE `contacts` ADD INDEX (`contact_project`);
ALTER TABLE `contacts` ADD INDEX (`contact_owner`);
ALTER TABLE `contacts` ADD INDEX (`contact_updatekey`);
ALTER TABLE `custom_fields_lists` ADD INDEX (`field_id`);
ALTER TABLE `custom_fields_lists` ADD INDEX (`list_option_id`);
ALTER TABLE `custom_fields_struct` ADD INDEX (`field_module`);
ALTER TABLE `custom_fields_struct` ADD INDEX (`field_page`);
ALTER TABLE `custom_fields_struct` ADD INDEX (`field_order`);
ALTER TABLE `custom_fields_values` ADD INDEX (`value_module`);
ALTER TABLE `custom_fields_values` ADD INDEX (`value_object_id`);
ALTER TABLE `custom_fields_values` ADD INDEX (`value_field_id`);
ALTER TABLE `departments` ADD INDEX (`dept_parent`);
ALTER TABLE `departments` ADD INDEX (`dept_company`);
ALTER TABLE `departments` ADD INDEX (`dept_name`);
ALTER TABLE `departments` ADD INDEX (`dept_owner`);
ALTER TABLE `departments` ADD INDEX (`dept_type`);
ALTER TABLE `events` ADD INDEX (`event_start_date`);
ALTER TABLE `events` ADD INDEX (`event_end_date`);
ALTER TABLE `events` ADD INDEX (`event_parent`);
ALTER TABLE `events` ADD INDEX (`event_owner`);
ALTER TABLE `events` ADD INDEX (`event_project`);
ALTER TABLE `events` ADD INDEX (`event_type`);
ALTER TABLE `event_queue` ADD INDEX (`queue_start`);
ALTER TABLE `event_queue` ADD INDEX (`queue_type`);
ALTER TABLE `event_queue` ADD INDEX (`queue_origin_id`);
ALTER TABLE `event_queue` ADD INDEX (`queue_module`);
ALTER TABLE `files` ADD INDEX (`file_project`);
ALTER TABLE `files` ADD INDEX (`file_task`);
ALTER TABLE `files` ADD INDEX (`file_name`);
ALTER TABLE `files` ADD INDEX (`file_parent`);
ALTER TABLE `files` ADD INDEX (`file_type`);
ALTER TABLE `files` ADD INDEX (`file_owner`);
ALTER TABLE `files` ADD INDEX (`file_category`);
ALTER TABLE `files` ADD INDEX (`file_folder`);
ALTER TABLE `files_index` ADD INDEX (`word`);
ALTER TABLE `file_folders` ADD INDEX (`file_folder_parent`);
ALTER TABLE `file_folders` ADD INDEX (`file_folder_name`);
ALTER TABLE `forums` ADD INDEX (`forum_project`);
ALTER TABLE `forums` ADD INDEX (`forum_status`);
ALTER TABLE `forums` ADD INDEX (`forum_owner`);
ALTER TABLE `forums` ADD INDEX (`forum_name`);
ALTER TABLE `forum_messages` ADD INDEX (`message_forum`);
ALTER TABLE `forum_messages` ADD INDEX (`message_parent`);
ALTER TABLE `forum_messages` ADD INDEX (`message_author`);
ALTER TABLE `forum_messages` ADD INDEX (`message_date`);
ALTER TABLE `forum_visits` ADD INDEX (`visit_user`);
ALTER TABLE `forum_visits` ADD INDEX (`visit_forum`);
ALTER TABLE `forum_visits` ADD INDEX (`visit_message`);
ALTER TABLE `forum_watch` ADD INDEX (`watch_user`);
ALTER TABLE `forum_watch` ADD INDEX (`watch_forum`);
ALTER TABLE `forum_watch` ADD INDEX (`watch_topic`);
ALTER TABLE `gacl_acl` ADD INDEX (`section_value`);
ALTER TABLE `gacl_acl` ADD INDEX (`enabled`);
ALTER TABLE `gacl_acl` ADD INDEX (`updated_date`);
ALTER TABLE `gacl_acl_sections` ADD INDEX (`value`);
ALTER TABLE `gacl_acl_sections` ADD INDEX (`hidden`);
ALTER TABLE `gacl_aco` ADD INDEX (`section_value`);
ALTER TABLE `gacl_aco` ADD INDEX (`hidden`);
ALTER TABLE `gacl_aco_sections` ADD INDEX (`value`);
ALTER TABLE `gacl_aco_sections` ADD INDEX (`hidden`);
ALTER TABLE `gacl_aro` ADD INDEX (`value`);
ALTER TABLE `gacl_aro` ADD INDEX (`hidden`);
ALTER TABLE `gacl_aro_groups` ADD INDEX (`parent_id`);
ALTER TABLE `gacl_aro_groups` ADD INDEX `lft_rgt` ( `lft` , `rgt` ) ;
ALTER TABLE `gacl_aro_groups` ADD INDEX (`value`);
ALTER TABLE `gacl_aro_sections` ADD INDEX (`value`);
ALTER TABLE `gacl_aro_sections` ADD INDEX (`hidden`);
ALTER TABLE `gacl_axo` ADD INDEX (`value`);
ALTER TABLE `gacl_axo` ADD INDEX (`hidden`);
ALTER TABLE `gacl_axo_groups` ADD INDEX (`parent_id`);
ALTER TABLE `gacl_axo_groups` ADD INDEX `lft_rgt` ( `lft` , `rgt` ) ;
ALTER TABLE `gacl_axo_groups` ADD INDEX (`value`);
ALTER TABLE `gacl_axo_sections` ADD INDEX (`value`);
ALTER TABLE `gacl_axo_sections` ADD INDEX (`hidden`);
ALTER TABLE `gacl_permissions` ADD INDEX (`user_id`);
ALTER TABLE `gacl_permissions` ADD INDEX (`user_name`);
ALTER TABLE `gacl_permissions` ADD INDEX (`module`);
ALTER TABLE `gacl_permissions` ADD INDEX (`item_id`);
ALTER TABLE `gacl_permissions` ADD INDEX (`action`);
ALTER TABLE `gacl_permissions` ADD INDEX (`acl_id`);
ALTER TABLE `links` ADD INDEX (`link_project`);
ALTER TABLE `links` ADD INDEX (`link_task`);
ALTER TABLE `links` ADD INDEX (`link_parent`);
ALTER TABLE `links` ADD INDEX (`link_owner`);
ALTER TABLE `links` ADD INDEX (`link_category`);
ALTER TABLE `modules` ADD INDEX (`mod_directory`);
ALTER TABLE `modules` ADD INDEX (`mod_type`);
ALTER TABLE `modules` ADD INDEX (`mod_ui_order`);
ALTER TABLE `modules` ADD INDEX (`mod_active`);
ALTER TABLE `modules` ADD INDEX (`permissions_item_table`);
ALTER TABLE `projects` ADD INDEX (`project_company`);
ALTER TABLE `projects` ADD INDEX (`project_name`);
ALTER TABLE `projects` ADD INDEX (`project_short_name`);
ALTER TABLE `projects` ADD INDEX (`project_start_date`);
ALTER TABLE `projects` ADD INDEX (`project_end_date`);
ALTER TABLE `projects` ADD INDEX (`project_status`);
ALTER TABLE `projects` ADD INDEX (`project_creator`);
ALTER TABLE `projects` ADD INDEX (`project_priority`);
ALTER TABLE `projects` ADD INDEX (`project_type`);
ALTER TABLE `projects` ADD INDEX (`project_parent`);
ALTER TABLE `projects` ADD INDEX (`project_original_parent`);
ALTER TABLE `project_contacts` ADD `project_contact_id` INT( 10 ) NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST;
ALTER TABLE `project_contacts` ADD INDEX (`project_id`);
ALTER TABLE `project_contacts` ADD INDEX (`contact_id`);
ALTER TABLE `project_departments` ADD `project_department_id` INT( 10 ) NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST;
ALTER TABLE `project_departments` ADD INDEX (`project_id`);
ALTER TABLE `project_departments` ADD INDEX (`department_id`);
ALTER TABLE `sessions` ADD INDEX (`session_updated`);
ALTER TABLE `sessions` ADD INDEX (`session_created`);
ALTER TABLE `sessions` ADD INDEX (`session_user`);
ALTER TABLE `syskeys` ADD INDEX (`syskey_name`);
ALTER TABLE `sysvals` ADD INDEX (`sysval_key_id`);
ALTER TABLE `sysvals` ADD INDEX (`sysval_title`);
ALTER TABLE `sysvals` ADD INDEX (`sysval_value_id`);
ALTER TABLE `tasks` ADD INDEX (`task_name`);
ALTER TABLE `tasks` ADD INDEX (`task_parent`);
ALTER TABLE `tasks` ADD INDEX (`task_project`);
ALTER TABLE `tasks` ADD INDEX (`task_owner`);
ALTER TABLE `tasks` ADD INDEX (`task_start_date`);
ALTER TABLE `tasks` ADD INDEX (`task_end_date`);
ALTER TABLE `tasks` ADD INDEX (`task_status`);
ALTER TABLE `tasks` ADD INDEX (`task_priority`);
ALTER TABLE `tasks` ADD INDEX (`task_creator`);
ALTER TABLE `tasks` ADD INDEX (`task_order`);
ALTER TABLE `tasks` ADD INDEX (`task_type`);
ALTER TABLE `tasks` ADD INDEX (`task_updator`);
ALTER TABLE `tasks_critical` ADD INDEX (`task_project`);
ALTER TABLE `tasks_problems` ADD INDEX (`task_project`);
ALTER TABLE `tasks_sum` ADD INDEX (`task_project`);
ALTER TABLE `tasks_summy` ADD INDEX (`task_project`);
ALTER TABLE `tasks_total` ADD INDEX (`task_project`);
ALTER TABLE `tasks_users` ADD INDEX (`task_project`);
ALTER TABLE `task_contacts` ADD `task_contact_id` INT( 10 ) NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST ;
ALTER TABLE `task_contacts` ADD INDEX (`contact_id`);
ALTER TABLE `task_contacts` ADD INDEX (`task_id`);
ALTER TABLE `task_departments` ADD `task_department_id` INT( 10 ) NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST ;
ALTER TABLE `task_departments` ADD INDEX (`department_id`);
ALTER TABLE `task_departments` ADD INDEX (`task_id`);
ALTER TABLE `task_log` ADD INDEX (`task_log_task`);
ALTER TABLE `task_log` ADD INDEX (`task_log_creator`);
ALTER TABLE `task_log` ADD INDEX (`task_log_date`);
ALTER TABLE `task_log` ADD INDEX (`task_log_costcode`);
ALTER TABLE `task_log` ADD INDEX (`task_log_problem`);
ALTER TABLE `users` ADD INDEX (`user_username`);
ALTER TABLE `users` ADD INDEX (`user_password`);
ALTER TABLE `users` ADD INDEX (`user_parent`);
ALTER TABLE `users` ADD INDEX (`user_type`);
ALTER TABLE `users` ADD INDEX (`user_company`);
ALTER TABLE `users` ADD INDEX (`user_department`);
ALTER TABLE `users` ADD INDEX (`user_owner`);
ALTER TABLE `users` ADD INDEX (`user_contact`);
ALTER TABLE `user_access_log` ADD INDEX (`user_id`);
ALTER TABLE `user_access_log` ADD INDEX (`date_time_in`);
ALTER TABLE `user_access_log` ADD INDEX (`date_time_out`);
ALTER TABLE `user_access_log` ADD INDEX (`date_time_last_action`);
ALTER TABLE `user_events` ADD `user_event_id` INT( 10 ) NOT NULL AUTO_INCREMENT PRIMARY KEY FIRST ;
ALTER TABLE `user_events` ADD INDEX (`user_id`);
ALTER TABLE `user_events` ADD INDEX (`event_id`);
ALTER TABLE `user_feeds` ADD INDEX (`feed_token`);
ALTER TABLE `user_preferences` ADD INDEX (`pref_user`);
ALTER TABLE `user_preferences` ADD INDEX (`pref_name`);
ALTER TABLE `user_tasks` ADD INDEX (`user_id`);
ALTER TABLE `user_tasks` ADD INDEX (`task_id`);
ALTER TABLE `user_task_pin` ADD INDEX (`user_id`);
ALTER TABLE `user_task_pin` ADD INDEX (`task_id`);

INSERT INTO w2pversion (code_version, db_version, last_code_update) VALUES ('1.1.0', 12, now());