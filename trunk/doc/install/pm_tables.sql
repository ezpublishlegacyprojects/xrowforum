CREATE TABLE `xrowforum_pm_messages` (
  `msg_id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  `sender` INTEGER UNSIGNED NOT NULL,
  `recipient` INTEGER UNSIGNED NOT NULL,
  `pm_subject` VARCHAR(255) NOT NULL,
  `pm_content` TEXT NOT NULL,
  `send_date` INTEGER UNSIGNED NOT NULL,
  `read_state` BOOLEAN NOT NULL,
  `owner_id` INTEGER UNSIGNED NOT NULL,
  PRIMARY KEY (`msg_id`)
)
ENGINE = InnoDB;



CREATE TABLE `xrowforum_pm_network` (
  `id` INTEGER UNSIGNED NOT NULL AUTO_INCREMENT,
  `user1` INTEGER UNSIGNED NOT NULL,
  `user2` INTEGER UNSIGNED NOT NULL,
  `state` INTEGER UNSIGNED NOT NULL,
  PRIMARY KEY (`id`)
)
ENGINE = InnoDB;