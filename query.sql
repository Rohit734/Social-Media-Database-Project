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


select post.post_id,user_id,users.username,caption,location,photos.photo_url,videos.video_url
from post join photos on post.photo_id = photos.id 
join videos on post.video_id = videos.id 
join users on  post.user_id = users.id order by user_id;

-- find total no of post
select users.username,count(users.username)
from post join users on  post.user_id = users.id group by user_id order by count(users.username) desc;

-- find followers
select username,count(follower_id) as followers from users join follows on users.id = follows.followee_id group by follows.followee_id order by followers desc;

-- total count of hashtag followed by users  
select users.username,count(hashtag_id) as total_hastag_followed
from hashtag_follow 
join users on hashtag_follow.user_id = users.id
group by users.username order by total_hastag_followed desc;

-- maximum followed hastag
select hashtag_name, count(hashtag_follow.hashtag_id)
from hashtags join hashtag_follow on
hashtags.id = hashtag_follow.hashtag_id group by hashtag_name
order by count(hashtag_follow.hashtag_id) desc limit 1;



-- total number of device user login from  
-- find total no of post per user or max no of post mad by user that makes 
-- find followers
-- total count of hashtag followed by users  
-- maximum followed hastag
-- who has higest like and in which post 
-- who made most of comments
-- which hashtag is mostly used in post 
-- max bookmark done by user
-- which post has higest bookmark 
-- who uploaded max videos and photos with size 
