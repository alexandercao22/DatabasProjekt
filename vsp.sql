-- DROP DATABASE IF EXISTS vsp;

DROP TABLE IF EXISTS Subscribes;
DROP TABLE IF EXISTS Comments;
DROP TABLE IF EXISTS Videos;
DROP TABLE IF EXISTS Channels;

DROP PROCEDURE IF EXISTS listComments;
DROP PROCEDURE IF EXISTS likeVideo;
DROP FUNCTION IF EXISTS getSubCount;
DROP PROCEDURE IF EXISTS listSubscribers;
DROP PROCEDURE IF EXISTS listSubscribedTo;
DROP PROCEDURE IF EXISTS getChannel;
DROP PROCEDURE IF EXISTS getVideo;
DROP PROCEDURE IF EXISTS listRandomChannels;
DROP PROCEDURE IF EXISTS listRandomVideos;
DROP PROCEDURE IF EXISTS listVideosByChannel;
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
(6, 6, 'Testing What Happens If You Jump On A Moving Train', 10571625, '2025-04-12', 247326, '00:18:15'),
(7, 6, 'Vortex Cannon vs Drone', 29387933, '2024-04-20', 591585, '00:20:43'),
(8, 6, 'My Secret Warehouse Tour', 36072083, '2022-06-15', 863866, '00:17:15'),
(9, 7, 'Tortoise vs. Hare - Who Wins?', 3829665, '2025-04-26', 67667, '00:14:59'),
(10, 7, 'Dude Perfect vs Keanu Reeves (150 MPH)', 5153086, '2025-01-25', 157236, '00:26:27'),
(11, 8, 'HANSIUS FLYTTAR IN | Edvin Törnblom', 457757, '2025-04-27', 12552, '01:12:17'),
(12, 8, 'HANSIUS FLYTTAR IN hos HAMPUS HEDSTRÖM', 2258103, '2020-03-29', 22894, '00:46:36'),
(13, 9, 'NBA Playoff Reaction', 154482, '2025-05-05', 1605, '00:16:33'),
(14, 9, 'Jake Paul vs. Mike Tyson FIGHT HIGHLIGHTS', 36494447, '2024-11-16', 274955, '00:02:34'),
(15, 10, '⁠SIDEMEN $5,000,000 SCAVENGER HUNT', 6070085, '2025-04-27', 209666, '01:39:08'),
(16, 10, '⁠SIDEMEN TEST VIRAL TIKTOK FOODS', 7279502, '2025-03-16', 196721, '01:28:10'),
(17, 11, '⁠Dream VS Daquavis $100,000 PvP Duel', 6038479, '2025-05-03', 469305, '00:35:25'),
(18, 11, 'Minecraft Speedrunner VS 3 Hunters GRAND FINALE', 136120019, '2020-08-07', 4902654, '00:41:47'),
(19, 12, 'THIS ISN’T GOOD | Schedule I', 1272868, '2025-04-30', 42208, '01:20:10'),
(20, 12, 'MY FIRST DEALER | Schedule I', 2600696, '2025-04-04', 132436, '01:30:52');

INSERT INTO Comments (comment_id, video_id, channel_id, upload_date, text, likes)
VALUES
(1, 1, 4, '2025-04-27', 'I like baguettes!', 420),
(2, 1, 2, '2025-04-28', 'Oui oui, merci sacre bleu', 59),
(3, 4, 18, '2025-05-01', 'I use Arch btw', 21050),
(4, 4, 12, '2025-05-03', 'Honestly the reactor setup is immaculate. Super cool vibe.', 215),
(5, 1, 2, '2022-08-03', 'This is my new second channel', 6410),
(6, 1, 6, '2024-05-22', 'This video... aged like fine wine... dont delete it lud', 14),
(7, 12, 8, '2020-03-29', 'Jååå, vilken youtuber ska jag flytta in hos härnäst?', 297),
(8, 12, 4, '2020-04-02', 'Fan vad bra kemi ni har fortsätt med det här!', 55),
(9, 8, 20, '2024-09-17', 'If I made something this cool I would never be able to keep it a secret for years lol', 2071),
(10, 6, 13, '2025-04-13', 'This is actually wild. Love the slow-mo shots!', 632),
(11, 7, 16, '2025-04-26', 'Imagine losing to a tortoise', 1583),
(12, 14, 11, '2024-11-17', 'They both swing like Minecraft players tbh', 4805),
(13, 3, 17, '2023-08-06', 'Bro this gave me Subnautica PTSD', 893),
(14, 2, 1, '2022-08-03', 'I did find it... just not $100,000', 672),
(15, 16, 18, '2025-03-17', 'TikTok food vs Linus Tech Tips tech – who wins?', 1741),
(16, 15, 10, '2025-04-28', 'I walked 10 miles for one of these clues... worth it.', 12906),
(17, 5, 15, '2012-12-25', 'My dad watches your channel while fixing the car, thanks lol', 8),
(18, 18, 14, '2020-08-08', 'Best manhunt ever. Peak Minecraft.', 24933),
(19, 19, 9, '2025-05-06', 'Not the best playoff take but I respect it.', 522),
(20, 20, 3, '2025-04-05', 'Schedule I arc is getting dark', 712),
(21, 13, 10, '2025-05-06', 'We need a Sidemen x NBA collab now ', 2940),
(22, 3, 5, '2023-08-06', 'I wouldn’t survive 7 minutes at sea', 203),
(23, 11, 17, '2025-04-27', 'Edvin carried this episode fr', 578),
(24, 6, 3, '2025-04-13', 'Jumping on a moving train? Classic YouTube.', 1999),
(25, 14, 1, '2024-11-17', 'I trained for this moment my entire life', 367),
(26, 9, 19, '2025-04-26', 'Tortoise had better stats ngl', 127),
(27, 10, 7, '2025-01-26', 'Keanu really pulled up like it’s John Wick 5', 9485),
(28, 17, 16, '2025-05-04', 'Daquavis got combo’d out of existence', 6934),
(29, 20, 15, '2025-04-05', 'That ending tho… never saw it coming', 1944),
(30, 4, 6, '2023-04-27', 'PewDiePie switching to Linux is my villain origin story', 3821),
(31, 8, 18, '2022-06-16', 'Warehouse setup: 10/10. Cable management: 3/10.', 10945),
(32, 2, 13, '2022-08-03', 'Did anyone actually find it? Asking for a friend.', 881),
(33, 15, 12, '2025-04-27', 'Scavenger hunt better than most movies tbh', 7210),
(34, 1, 14, '2025-04-28', 'MrBeast Gaming takes over French bakeries now?', 542),
(35, 12, 11, '2025-05-01', '“PvP Duel” was intense. My palms were sweating.', 3201),
(36, 7, 4, '2025-04-27', 'This rabbit should join Dude Perfect', 144),
(37, 16, 2, '2024-04-21', 'You guys have officially won YouTube.', 33128),
(38, 18, 20, '2023-04-26', 'Linux gang rise up.', 2503),
(39, 19, 8, '2025-04-27', 'Imponerande. Ni får gärna flytta in hos oss på Expressen!', 191),
(40, 13, 17, '2025-04-13', 'Train jump felt like a GTA stunt jump bonus', 652);

INSERT INTO Subscribes (subscriber_id, subscribed_to_id)
VALUES
(1, 2), (1, 3), (3, 5), (2, 4), (12, 7), (3, 1), (16, 9), (10, 19), (8, 6), (1, 18), (6, 3), (14, 11), 
(9, 20), (20, 5), (5, 17), (2, 14), (17, 1), (7, 10), (19, 16), (4, 8), (11, 13), (13, 2), (18, 4), 
(15, 15), (12, 19), (3, 16), (10, 1), (6, 14), (1, 7), (16, 20), (8, 12), (14, 3), (9, 5), (20, 18), 
(5, 8), (2, 2), (17, 11), (7, 6), (19, 19), (4, 1), (11, 9), (13, 17), (18, 15), (15, 4);
