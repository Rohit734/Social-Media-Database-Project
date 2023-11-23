create SCHEMA IF NOT EXISTS SocialMedia;
use SocialMedia;
-- drop database SocialMedia;



CREATE TABLE users(
	id int PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(255),
    profile_photo_url VARCHAR(255),
    bio TEXT,
    email VARCHAR(255) 
);

CREATE TABLE hashtags (
    id INT AUTO_INCREMENT PRIMARY KEY,
    hashtag_name VARCHAR(255) UNIQUE
);

CREATE TABLE follows (
	id int PRIMARY KEY AUTO_INCREMENT,
    follower_id int,
    followee_id int,
    FOREIGN KEY (follower_id) REFERENCES users(id),
    FOREIGN KEY (followee_id) REFERENCES users(id)
);

CREATE TABLE photos (
	id int PRIMARY KEY AUTO_INCREMENT,
    photo_url VARCHAR(255),
    post_id INT,
    size INT
);

CREATE TABLE videos (
	id int primary key auto_increment,
    video_url varchar(255),
    size int,
    post_id int
);

-- CREATE TABLE photos (
-- 	id int PRIMARY KEY AUTO_INCREMENT,
--     photo_url VARCHAR(255),
--     post_id INT,
--     size INT,
--     FOREIGN KEY (post_id) REFERENCES posts(post_id)
-- );

-- CREATE TABLE videos (
-- 	id int primary key auto_increment,
--     video_url varchar(255),
--     size int,
--     post_id int,
--     foreign key (post_id) references posts(post_id)
-- );

CREATE TABLE post(
	post_id int PRIMARY KEY AUTO_INCREMENT,
	photo_id int,
	video_id int,
    user_id int,
    caption TEXT,
    location VARCHAR(255),
	FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (photo_id) REFERENCES photos(id),
    FOREIGN KEY (video_id) REFERENCES videos(id)
);

create table post_tags(
	id int primary key	auto_increment,
	post_id int,
	hashtag_id int,
	foreign key (post_id) references post(post_id),
	foreign key (hashtag_id) references hashtags(id)
);

create table post_likes(
	id int PRIMARY KEY AUTO_INCREMENT,
	post_id int,
	user_id int,
	foreign key (post_id) references post(post_id),
	foreign key (user_id) references users(id)
);

create table bookmarks(
	id int primary key	auto_increment,
	post_id int,
	user_id int,
	foreign key (post_id) references post(post_id),
	foreign key (user_id) references users(id)
);

create table comments(
	id int primary key	auto_increment,
	comment_text text,
	post_id int,
	user_id int,
	foreign key (post_id) references post(post_id),
	foreign key (user_id) references users(id)
);

create table comment_likes(
	id int primary key	auto_increment,
	user_id int,
	comment_id int,
	foreign key (comment_id) references comments(id),
	foreign key (user_id) references users(id)
);

create table hashtag_follow (
	id int primary key	auto_increment,
	user_id int,
	hashtag_id int,
	foreign key (hashtag_id) references hashtags(id),
	foreign key (user_id) references users(id)
);

create table LOGIN (
	id int primary key	auto_increment,
	user_id int,
	ip varchar(30),
	foreign key (user_id) references users(id)
);






