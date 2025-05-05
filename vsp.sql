DROP DATABASE IF EXISTS vsp;

CREATE DATABASE vsp;
USE vsp;

DROP TABLE IF EXISTS Subscribes;
DROP TABLE IF EXISTS Comments;
DROP TABLE IF EXISTS Videos;
DROP TABLE IF EXISTS Channels;

DROP PROCEDURE IF EXISTS listComments;
DROP FUNCTION IF EXISTS getSubCount;
DROP PROCEDURE IF EXISTS listSubscribers;
DROP PROCEDURE IF EXISTS listSubscribedTo;
DROP PROCEDURE IF EXISTS listRandomChannels;
DROP PROCEDURE IF EXISTS listRandomVideos;
DROP PROCEDURE IF EXISTS search;
DROP PROCEDURE IF EXISTS searchSorted;

CREATE TABLE Channels (channel_id int NOT NULL, channel_name varchar(64) NOT NULL, creation_date date, country varchar(64), PRIMARY KEY (channel_id));
CREATE TABLE Videos (video_id int NOT NULL, channel_id int NOT NULL, video_name varchar(64), views int, upload_date date, likes int, length time, PRIMARY KEY (video_id), FOREIGN KEY (channel_id) REFERENCES Channels(channel_id));
CREATE TABLE Comments (comment_id int NOT NULL, video_id int NOT NULL, channel_id int NOT NULL, upload_date date, text varchar(256), likes int, PRIMARY KEY (comment_id), FOREIGN KEY (video_id) REFERENCES Videos(video_id), FOREIGN KEY (channel_id) REFERENCES Channels(channel_id));
CREATE TABLE Subscribes (subscriber_id int NOT NULL, subscribed_to_id int NOT NULL, PRIMARY KEY (subscriber_id, subscribed_to_id), FOREIGN KEY (subscriber_id) REFERENCES Channels(channel_id), FOREIGN KEY (subscribed_to_id) REFERENCES Channels(channel_id));

INSERT INTO Channels (channel_id, channel_name, creation_date, country)
VALUES
(1, 'Ludwig', '2011-08-15', 'USA'),
(2, 'MrBeast', '2012-02-20', 'USA'),
(3, 'PewDiePie', '2010-04-29', "Japan"),
(4, 'SampeV2', '2013-03-04', 'Sweden'),
(5, 'ILIKEcars', '2012-07-12', 'Albania'),
(6, 'Mark Rober', '2011-10-20', 'USA'),
(7, 'Dude Perfect', '2009-03-17', 'USA'),
(8, 'Emil Hansius', '2016-08-03', 'Sweden'),
(9, 'ESPN', '2005-11-01', 'USA'),
(10, 'Sidemen', '2015-06-14', 'UK'),
(11, 'Dream', '2014-02-08', 'USA'),
(12, 'jacksepticeye', '2007-02-01', 'Ireland'),
(13, 'Asmongold TV', '2019-12-09', 'USA'),
(14, 'MrBeast Gaming', '2020-04-07', 'USA'),
(15, 'Anomaly', '2007-03-21', 'Sweden'),
(16, 'VanossGaming', '2011-09-15', 'USA'),
(17, 'SMii7Y', '2011-04-18', 'Canada'),
(18, 'Linus Tech Tips', '2008-11-25', 'Canada'),
(19, 'Expressen', '2008-10-06', 'Sweden'),
(20, 'HowToBasic', '2011-12-08', 'Australia');

INSERT INTO Videos (video_id, channel_id, video_name, views, upload_date, likes, length)
VALUES
(1, 1, 'I Opened a French Bakery for 24 Hours!', 928, '2025-04-27', 59, '00:22:12'),
(2, 1, 'I Burried $100,000, Go Find It', 16000, '2022-08-02', 600, '00:11:42'),
(3, 2, '7 Days Stranded At Sea', 355000, '2023-08-05', 7900, '00:18:04'),
(4, 3, 'I installed Linux (so should you)', 3401, '2023-04-26', 160, '00:22:52'),
(5, 5, 'How to fix your cars', 5000, '2012-12-24', 2, '00:35:40'),
(6, 6, 'Testing What Happens If You Jump On A Moving Train', 10571625, '2025-04-12', '00:18:15'),
(7, 6, 'Vortex Cannon vs Drone', 29387933, '2024-04-20', '00:20:43'),
(8, 6, 'My Secret Warehouse Tour', 36072083, '2022-06-15', '00:17:15'),
(9, 7, 'Tortoise vs. Hare - Who Wins?', 3829665, '2025-04-26', '00:14:59'),
(10, 7, 'Dude Perfect vs Keanu Reeves (150 MPH)', 5153086, '2025-01-25', '00:26:27'),
(11, 8, 'HANSIUS FLYTTAR IN | Edvin Törnblom', 457757, '2025-04-27', '01:12:17'),
(12, 8, 'HANSIUS FLYTTAR IN hos HAMPUS HEDSTRÖM', 2258103, '2020-03-29', '00:46:36'),
(13, 9, 'NBA Playoff Reaction', 154482, '2025-05-05', '00:16:33'),
(14, 9, 'Jake Paul vs. Mike Tyson FIGHT HIGHLIGHTS', 36494447, '2024-11-16', '00:02:34'),
(15, 10, '⁠SIDEMEN $5,000,000 SCAVENGER HUNT', 6070085, '2025-04-27', '01:39:08'),
(16, 10, '⁠SIDEMEN TEST VIRAL TIKTOK FOODS', 7279502, '2025-03-16', '01:28:10'),
(17, 11, '⁠Dream VS Daquavis $100,000 PvP Duel', 6038479, '2025-05-03', '00:35:25'),
(18, 11, 'Minecraft Speedrunner VS 3 Hunters GRAND FINALE', 136120019, '2020-08-07', '00:41:47'),
(19, 12, 'THIS ISN’T GOOD | Schedule I', 1272868, '2025-04-30', '01:20:10'),
(20, 12, 'MY FIRST DEALER | Schedule I', 2600696, '2025-04-04', '01:30:52');

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
	SELECT *, getSubCount(Channels.channel_id) AS sub_count FROM Channels
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
	SELECT channel_id AS ID, channel_name AS Name, getSubCount(channel_id) AS Metric, 'Channel' AS Type FROM Channels
		WHERE channel_name LIKE concat('%', searchString, '%')
	UNION
	SELECT video_id AS ID, video_name AS Name, views AS Metric, 'Video' AS Type FROM Videos
		WHERE video_name LIKE concat('%', searchString, '%')
        ORDER BY RAND();
END//

CREATE PROCEDURE searchSorted(IN searchString varchar(64))
NOT DETERMINISTIC
BEGIN
	SELECT channel_id AS ID, channel_name AS Name, getSubCount(channel_id) AS Metric, 'Channel' AS Type FROM Channels
		WHERE channel_name LIKE concat('%', searchString, '%')
	UNION
	SELECT video_id AS ID, video_name AS Name, views AS Metric, 'Video' AS Type FROM Videos
		WHERE video_name LIKE concat('%', searchString, '%')
        ORDER BY Type ASC, Metric DESC;
END//
DELIMITER ;

SELECT * FROM Videos;

CALL searchSorted('a');
CALL search('a');
CALL listRandomChannels(10);
