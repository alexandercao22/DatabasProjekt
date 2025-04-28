CREATE DATABASE vsp;
USE vsp;

CREATE TABLE Channels (channel_id int NOT NULL, channel_name varchar(64) NOT NULL, creation_date date, country varchar(64), PRIMARY KEY (channel_id));
CREATE TABLE Videos (video_id int NOT NULL, channel_id int NOT NULL, video_name varchar(64), views int, upload_date date, likes int, length time, PRIMARY KEY (video_id), FOREIGN KEY (channel_id) REFERENCES channels(channel_id));
CREATE TABLE Comments (comment_id int NOT NULL, video_id int NOT NULL, channel_id int NOT NULL, upload_date date, text varchar(256), likes int, PRIMARY KEY (comment_id), FOREIGN KEY (video_id) REFERENCES videos(video_id), FOREIGN KEY (channel_id) REFERENCES channels(channel_id));
CREATE TABLE Subscribes (subscriber_id int NOT NULL, subscribed_to_id int NOT NULL, PRIMARY KEY (subscriber_id, subscribed_to_id), FOREIGN KEY (subscriber_id) REFERENCES channels(channel_id), FOREIGN KEY (subscribed_to_id) REFERENCES channels(channel_id));

SELECT * FROM channels;
INSERT INTO Channels (channel_id, channel_name, creation_date, country)
VALUES
(1, 'Ludwig', '2011-08-15', 'USA');