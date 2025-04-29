DELIMITER //
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
END//

CREATE PROCEDURE search(IN searchString varchar(64))
NOT DETERMINISTIC
BEGIN
	SELECT channel_name AS SearchResult, getSubCount(channel_id) AS Total FROM Channels
		WHERE channel_name LIKE concat('%', searchString, '%')
	UNION
	SELECT video_name, views FROM Videos
		WHERE video_name LIKE concat('%', searchString, '%');
END//

CREATE PROCEDURE searchSorted(IN searchString varchar(64))
NOT DETERMINISTIC
BEGIN
	SELECT channel_name AS Name, getSubCount(channel_id) AS Metric, 1 AS SortOrder FROM Channels
		WHERE channel_name LIKE concat('%', searchString, '%')
	UNION
	SELECT video_name AS Name, views AS Metric, 2 AS SortOrder FROM Videos
		WHERE video_name LIKE concat('%', searchString, '%')
        ORDER BY SortOrder ASC, Metric DESC;
END//
DELIMITER ;

DROP PROCEDURE search;
DROP PROCEDURE searchSorted;

CALL search('l');
CALL searchSorted('a');