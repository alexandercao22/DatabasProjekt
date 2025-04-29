CREATE DATABASE vsp;
USE vsp;

CREATE TABLE Channels (channel_id int NOT NULL, channel_name varchar(64) NOT NULL, creation_date date, country varchar(64), PRIMARY KEY (channel_id));
CREATE TABLE Videos (video_id int NOT NULL, channel_id int NOT NULL, video_name varchar(64), views int, upload_date date, likes int, length time, PRIMARY KEY (video_id), FOREIGN KEY (channel_id) REFERENCES channels(channel_id));
CREATE TABLE Comments (comment_id int NOT NULL, video_id int NOT NULL, channel_id int NOT NULL, upload_date date, text varchar(256), likes int, PRIMARY KEY (comment_id), FOREIGN KEY (video_id) REFERENCES videos(video_id), FOREIGN KEY (channel_id) REFERENCES channels(channel_id));
CREATE TABLE Subscribes (subscriber_id int NOT NULL, subscribed_to_id int NOT NULL, PRIMARY KEY (subscriber_id, subscribed_to_id), FOREIGN KEY (subscriber_id) REFERENCES channels(channel_id), FOREIGN KEY (subscribed_to_id) REFERENCES channels(channel_id));

SELECT * FROM channels;
INSERT INTO Channels (channel_id, channel_name, creation_date, country)
VALUES
(1, 'Ludwig', '2011-08-15', 'USA'),
(2, 'MrBeast', '2012-02-20', 'USA'),
(3, 'PewDiePie', '2010-04-29', "Japan"),
(4, 'SampeV2', '2013-03-04', 'Sweden'),
(5, 'ILIKEcars', '2012-07-12', 'Albania');

INSERT INTO Videos (video_id, channel_id, video_name, views, upload_date, likes, length)
VALUES
(1, 1, 'I Opened a French Bakery for 24 Hours!', 928, '2025-04-27', 59, '00:22:12'),
(2, 1, 'I Burried $100,000, Go Find It', 16000, '2022-08-02', 600, '00:11:42'),
(3, 2, '7 Days Stranded At Sea', 355000, '2023-08-05', 7900, '00:18:04'),
(4, 3, 'I installed Linux (so should you)', 3401, '2023-04-26', 160, '00:22:52'),
(5, 5, 'How to fix your cars', 5000, '2012-12-24', 2, '00:35:40'),
(6, 4, 'Tråkig video haha', 0, '2025-04-28', 0, '00:11:11');

INSERT INTO Comments (comment_id, video_id, channel_id, upload_date, text, likes)
VALUES
(1, 1, 4, '2025-04-27', 'I like baguettes!', 420),
(2, 1, 2, '2025-04-28', 'Oui oui, merci sacre bleu', 59);

INSERT INTO Subscribes (subscriber_id, subscribed_to_id)
VALUES
(1, 2),
(1, 3),
(3, 5),
(2, 4),
(4, 2),
(1, 4),
(3, 4);
