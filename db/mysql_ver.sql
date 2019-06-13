-- 使うDBをmysqlからpostgresqlにしたので、これは使わない。

-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied
CREATE TABLE users (
    id         INT(10) UNSIGNED AUTO_INCREMENT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY(id)
);

CREATE TABLE profiles (
    user_id      INT(10) UNSIGNED  NOT NULL,
    nickname     VARCHAR(255)      NOT NULL,
    introduction TEXT              NOT NULL,
    avatar       VARCHAR(255),
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_introduction_user_id
        FOREIGN KEY (user_id) REFERENCES users(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    PRIMARY KEY(user_id)    
);

CREATE TABLE carriers (
    user_id         INT(10) UNSIGNED NOT NULL,
    compoany_name   VARCHAR(255)     NOT NULL,
    job_name        VARCHAR(255)     NOT NULL,
    start_date      DATETIME,
    end_date        DATETIME,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_carrier_user_id
        FOREIGN KEY (user_id) REFERENCES users(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    PRIMARY KEY(user_id)
);

CREATE TABLE links (
    id              INT(10) UNSIGNED AUTO_INCREMENT,
    user_id         INT(10) UNSIGNED NOT NULL,
    title           VARCHAR(255)     NOT NULL,
    url             VARCHAR(255)     NOT NULL,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_link_user_id
        FOREIGN KEY (user_id) REFERENCES users(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    PRIMARY KEY(id)
);

CREATE TABLE works (
    id              INT(10) UNSIGNED AUTO_INCREMENT,
    user_id         INT(10) UNSIGNED NOT NULL,
    title           VARCHAR(255)     NOT NULL,
    sub_title       VARCHAR(255)     NOT NULL,
    description     TEXT,
    url             VARCHAR(255),
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_work_user_id
        FOREIGN KEY (user_id) REFERENCES users(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    PRIMARY KEY(id)
);

CREATE TABLE work_photos (
    work_id         INT(10) UNSIGNED NOT NULL,
    photo_path      VARCHAR(255) NOT NULL,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    CONSTRAINT fk_work_work_id
        FOREIGN KEY (work_id) REFERENCES works(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    PRIMARY KEY(work_id)
);

CREATE TABLE skills (
    id              INT(10) UNSIGNED AUTO_INCREMENT,
    name            VARCHAR(255)     NOT NULL,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY(id)
) COMMENT="スキルのマスタテーブル";

CREATE TABLE user_skills (
    user_id         INT(10) UNSIGNED,
    skill_id        INT(10) UNSIGNED,
    level           TINYINT(1),
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_user_skill_user_id
        FOREIGN KEY (user_id) REFERENCES users(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    CONSTRAINT fk_user_skill_skill_id
        FOREIGN KEY (skill_id) REFERENCES skills(id)
        ON UPDATE CASCADE
        ON DELETE CASCADE,
    PRIMARY KEY(user_id, skill_id)
) COMMENT="ユーザーとスキルの中間テーブル";

-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back
DROP TABLE user_skills;
DROP TABLE skills;
DROP TABLE work_photos;
DROP TABLE works;
DROP TABLE links;
DROP TABLE carriers;
DROP TABLE profiles;
DROP TABLE users;
