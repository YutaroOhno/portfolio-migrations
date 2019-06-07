
-- +goose Up
-- SQL in section 'Up' is executed when this migration is applied
CREATE TABLE users (
    id         INT(10) UNSIGNED AUTO_INCREMENT,
    nickname   VARCHAR(255) NOT NULL,
    avatar     VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY(id)
);

CREATE TABLE introductions (
    user_id      INT(10) UNSIGNED NOT NULL,
    introduction VARCHAR(2000) NOT NULL,
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
    compoany_name   VARCHAR(255),
    job_name        VARCHAR(255),
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
    title           VARCHAR(255),
    url             VARCHAR(255),
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
    title           VARCHAR(255),
    sub_title       VARCHAR(255),
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

-- +goose Down
-- SQL section 'Down' is executed when this migration is rolled back
DROP TABLE work_photos;
DROP TABLE works;
DROP TABLE links;
DROP TABLE carriers;
DROP TABLE introductions;
DROP TABLE users;
