DELIMITER //
CREATE PROCEDURE listComments(
	IN video_id INT
)
BEGIN
	SELECT Comments.channel_id, Channels.channel_name, Comments.upload_date, comments.text, comments.likes FROM 
    Comments INNER JOIN Channels ON Comments.channel_id = Channels.channel_id
    WHERE video_id = Comments.video_id;
END //

CREATE PROCEDURE likeVideo(
	IN video_id INT
)
BEGIN
	UPDATE Videos
    SET Videos.likes = Videos.likes + 1
    WHERE Videos.video_id = video_id;
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
	SELECT *, getSubCount(Channels.channel_id) AS sub_count FROM 
    Channels INNER JOIN Subscribes ON Channels.channel_id = Subscribes.Subscribed_to_id
    WHERE channel_id = Channels.channel_id;
END //

CREATE PROCEDURE listSubscribedTo(
	IN channel_id INT
)
BEGIN
	SELECT *, getSubCount(Channels.channel_id) AS sub_count FROM 
    Channels INNER JOIN Subscribes ON Channels.channel_id = Subscribes.subscribed_to_id
    WHERE channel_id = Subscribes.subscriber_id;
END //

CREATE PROCEDURE getChannel(
	IN channel_id INT
)
BEGIN
	SELECT *, getSubCount(Channels.channel_id) AS sub_count FROM Channels 
    WHERE Channels.channel_id = channel_id;
END //

CREATE PROCEDURE getVideo(
	IN video_id INT
)
BEGIN
	SELECT * FROM Videos 
    WHERE Videos.video_id = video_id;
END //

CREATE PROCEDURE listRandomChannels(
	IN count INT
)
BEGIN
	SELECT *, getSubCount(channel_id) AS sub_count FROM Channels
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

CREATE PROCEDURE listVideosByChannel(
	IN channel_id INT
)
BEGIN
	SELECT * FROM Videos
    WHERE Videos.channel_id = channel_id
        ORDER BY Videos.upload_date;
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
