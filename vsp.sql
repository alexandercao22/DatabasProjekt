CREATE DATABASE vsp;
USE vsp;

CREATE TABLE Channels (channel_id int NOT NULL, channel_name varchar(64) NOT NULL, creation_date date, country varchar(64), PRIMARY KEY (channel_id));
CREATE TABLE Videos (video_id int NOT NULL, channel_id int NOT NULL, video_name varchar(64), views int, upload_date date, likes int, length time, PRIMARY KEY (video_id), FOREIGN KEY (channel_id) REFERENCES channels(channel_id));
CREATE TABLE Comments (comment_id int NOT NULL, video_id int NOT NULL, channel_id int NOT NULL, upload_date date, text varchar(256), likes int, PRIMARY KEY (comment_id), FOREIGN KEY (video_id) REFERENCES videos(video_id), FOREIGN KEY (channel_id) REFERENCES channels(channel_id));
CREATE TABLE Subscribes (subscriber_id int NOT NULL, subscribed_to_id int NOT NULL, PRIMARY KEY (subscriber_id, subscribed_to_id), FOREIGN KEY (subscriber_id) REFERENCES channels(channel_id), FOREIGN KEY (subscribed_to_id) REFERENCES channels(channel_id));

INSERT INTO Channels (channel_id, channel_name, creation_date, country)
VALUES
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
(5, 5, 'How to fix your cars', 5000, '2012-12-24', 2, '00:35:40');

INSERT INTO Comments (comment_id, video_id, channel_id, upload_date, text, likes)
VALUES
(1, 1, 4, '2025-04-27', 'I like baguettes!', 420),
(2, 1, 2, '2025-04-28', 'Oui oui, merci sacre bleu', 59);

INSERT INTO Subscribes (subscriber_id, subscribed_to_id)
VALUES
(1, 2),
(1, 3),
(3, 5),
(2, 4);

DELIMITER //
CREATE PROCEDURE listComments(
	IN video_id INT
)
BEGIN
	SELECT Channels.channel_name, Comments.upload_date, Comments.text FROM 
    Comments INNER JOIN Channels ON Comments.channel_id = Channels.channel_id
    WHERE video_id = Comments.video_id;
END //

CREATE FUNCTION getSubCount(
	channel_id INT
)
RETURNS INT
DETERMINISTIC
BEGIN
	DECLARE result INT;
    
    SELECT COUNT(subscriber_id) INTO result FROM Subscribes
    WHERE channel_id = subscribed_to_id;
    RETURN result;
END //

CREATE PROCEDURE listSubscribers(
	IN channel_id INT
)
BEGIN
	SELECT Channels.channel_name, getSubCount(Channels.channel_id) AS sub_count FROM 
    Channels INNER JOIN Subscribes ON Channels.channel_id = Subscribes.Subscribed_to_id
    WHERE channel_id = Channels.channel_id;
END //

CREATE PROCEDURE listSubscribedTo(
	IN channel_id INT
)
BEGIN
	SELECT Channels.channel_name, getSubCount(Channels.channel_id) AS sub_count FROM 
    Channels INNER JOIN Subscribes ON Channels.channel_id = Subscribes.subscribed_to_id
    WHERE channel_id = Subscribes.subscriber_id;
END //

CREATE PROCEDURE listRandomChannels(
	IN count INT
)
BEGIN
	SELECT * FROM Channels
    ORDER BY RAND()
    LIMIT count;
END //

CREATE PROCEDURE listRandomVideos(
	IN count INT
)
BEGIN
	SELECT * FROM Videos
    ORDER BY RAND()
    LIMIT count;
END //

CREATE PROCEDURE search(IN searchString varchar(64))
NOT DETERMINISTIC
BEGIN
	SELECT channel_id AS ID, channel_name AS SearchResult, getSubCount(channel_id) AS Total FROM Channels
		WHERE channel_name LIKE concat('%', searchString, '%')
	UNION
	SELECT video_id AS ID, video_name, views FROM Videos
		WHERE video_name LIKE concat('%', searchString, '%');
END//

CREATE PROCEDURE searchSorted(IN searchString varchar(64))
NOT DETERMINISTIC
BEGIN
	SELECT channel_id AS ID, channel_name AS Name, getSubCount(channel_id) AS Metric, 1 AS SortOrder FROM Channels
		WHERE channel_name LIKE concat('%', searchString, '%')
	UNION
	SELECT video_id AS ID, video_name AS Name, views AS Metric, 2 AS SortOrder FROM Videos
		WHERE video_name LIKE concat('%', searchString, '%')
        ORDER BY SortOrder ASC, Metric DESC;
END//
DELIMITER ;

DROP PROCEDURE searchSorted;

CALL searchSorted('a');
