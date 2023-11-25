-- SELECT STATEMENT
select * from users order by id;
select * from photos order by id;
select * from videos order by id;
select * from bookmarks order by id;
select * from comment_likes order by id;
select * from comments order by id;
select * from follows order by id;
select * from hashtag_follow order by id;
select * from hashtags order by id;
select * from LOGIN order by id;
select * from post_likes order by id;
select * from post order by post_id;
select * from post_tags order by id;

-- joining user, post, videos, photos table
select post.post_id,user_id,email,users.username,caption,location,photos.photo_url,videos.video_url
from post join photos on post.photo_id = photos.id 
join videos on post.video_id = videos.id 
join users on  post.user_id = users.id order by user_id;

-- delete user with no emails
delete from users where email='.' or email="";


-- find total no of post
select users.username,count(users.username)
from post join users on  post.user_id = users.id 
group by user_id order by count(users.username) desc;

-- user with Maximum followers
select username,count(follower_id) as followers from users 
join follows on users.id = follows.followee_id 
group by follows.followee_id order by followers desc limit 1;

-- number of hashtag followed by users  
select users.username,count(hashtag_id) as total_hastag_followed
from hashtag_follow 
join users on hashtag_follow.user_id = users.id
group by users.username order by total_hastag_followed desc;

-- Trends hastag
select hashtag_name, count(hashtag_follow.hashtag_id)
from hashtags join hashtag_follow on
hashtags.id = hashtag_follow.hashtag_id group by hashtag_name
order by count(hashtag_follow.hashtag_id) desc limit 1;

-- total number of device user login from
select username,count(ip) as No_of_devices from users 
join login on users.id = login.user_id group by username 
order by No_of_devices desc;
  
-- find total no of post per user 
select username, count(post_id) as total_post from users 
join post on users.id = post.user_id group by username order by total_post desc; 

-- user with max post 
select username, count(post_id) as total_post from users 
join post on users.id = post.user_id group by username 
order by total_post desc limit 1; 

-- find followers per users
select username,count(follower_id) as followers from users 
join follows on users.id = follows.followee_id 
group by follows.followee_id order by followers desc;

-- who has higest like and in which post
SELECT users.username, post.location, post.caption, photos.photo_url, videos.video_url
FROM users
JOIN post ON users.id = post.user_id
LEFT JOIN photos ON post.photo_id = photos.id
LEFT JOIN videos ON post.video_id = videos.id
WHERE post.post_id = (
    SELECT post.post_id
    FROM post
    JOIN post_likes ON post.post_id = post_likes.post_id
    GROUP BY post.post_id
    ORDER BY COUNT(post_likes.post_id) DESC
    LIMIT 1
);

-- who made most of comments
SELECT users.username, COUNT(comments.id) AS comment_count
FROM users
JOIN comments ON users.id = comments.user_id
GROUP BY users.id
ORDER BY comment_count DESC
LIMIT 1;

-- which post has most comment 
SELECT post.post_id, COUNT(comments.id) AS comment_count,photos.photo_url, videos.video_url
FROM post
LEFT JOIN photos ON post.photo_id = photos.id
LEFT JOIN videos ON post.video_id = videos.id
LEFT JOIN comments ON post.post_id = comments.post_id
GROUP BY post.post_id
ORDER BY comment_count DESC
LIMIT 1;

-- which hashtag is mostly used in post 
SELECT hashtags.hashtag_name, COUNT(post_tags.id) AS tag_count
FROM hashtags
JOIN post_tags ON hashtags.id = post_tags.hashtag_id
GROUP BY hashtags.id
ORDER BY tag_count DESC
LIMIT 1;

-- max bookmark done by user
SELECT users.username, COUNT(bookmarks.id) AS bookmark_count
FROM users
JOIN bookmarks ON users.id = bookmarks.user_id
GROUP BY users.id
ORDER BY bookmark_count DESC
LIMIT 1;

-- which post has higest bookmark 
SELECT post.post_id, COUNT(bookmarks.id) AS bookmark_count,photos.photo_url, videos.video_url
FROM post
LEFT JOIN photos ON post.photo_id = photos.id
LEFT JOIN videos ON post.video_id = videos.id
LEFT JOIN bookmarks ON post.post_id = bookmarks.post_id
GROUP BY post.post_id
ORDER BY bookmark_count DESC
LIMIT 1;

-- who uploaded max videos and photos with size 
SELECT users.username, 
	SUM(IF(photos.id IS NOT NULL, 1, 0)) AS photo_count,
    SUM(IF(videos.id IS NOT NULL, 1, 0)) AS video_count,
    SUM(IF(photos.id IS NOT NULL,photos.size,0)) AS Photo_size,
    SUM(IF(videos.id IS NOT NULL,Videos.size,0)) AS Video_size,
    SUM(IF(photos.id IS NOT NULL AND videos.id IS NOT NULL, photos.size + videos.size, 0)) AS total_size
FROM users
LEFT JOIN post ON users.id = post.user_id
LEFT JOIN photos ON post.photo_id = photos.id
LEFT JOIN videos ON post.video_id = videos.id
GROUP BY users.id
ORDER BY total_size DESC
LIMIT 1;

