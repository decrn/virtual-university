BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "tbl_Persons" (
	"col_id"	integer UNIQUE,
	"col_firstname"	varchar(30),
	"col_lastname"	varchar(30),
	"col_username"	varchar(30),
	"col_email"	varchar(255),
	PRIMARY KEY("col_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "tbl_TeacherTypes" (
	"col_id"	integer,
	"col_teachertype"	varchar(30),
	PRIMARY KEY("col_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "tbl_Teachers" (
	"col_id"	integer UNIQUE,
	"col_employee_id"	varchar(30) UNIQUE,
	"col_teachertype"	integer,
	"col_person"	integer,
	PRIMARY KEY("col_id" AUTOINCREMENT),
	FOREIGN KEY("col_person") REFERENCES "tbl_Persons"("col_id"),
	FOREIGN KEY("col_teachertype") REFERENCES "tbl_TeacherTypes"("col_id")
);
CREATE TABLE IF NOT EXISTS "tbl_Students" (
	"col_id"	integer UNIQUE,
	"col_student_id"	varchar(30) UNIQUE,
	"col_person"	integer,
	PRIMARY KEY("col_id" AUTOINCREMENT),
	FOREIGN KEY("col_person") REFERENCES "tbl_Persons"("col_id")
);
CREATE TABLE IF NOT EXISTS "tbl_Courses" (
	"col_id"	integer UNIQUE,
	"col_coursenumber"	varchar(30) UNIQUE,
	"col_name"	varchar(30),
	"col_ects_credits"	integer,
	"col_grading_information"	varchar(255),
	PRIMARY KEY("col_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "tbl_Classtypes" (
	"col_id"	integer UNIQUE,
	"col_classtype"	varchar(30),
	PRIMARY KEY("col_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "tbl_Classes" (
	"col_id"	integer UNIQUE,
	"col_startdate"	datetime,
	"col_enddate"	datetime,
	"col_course"	integer,
	"col_subject"	varchar(255),
	"col_classtype"	integer,
	"col_teacher"	integer,
	FOREIGN KEY("col_classtype") REFERENCES "tbl_Classtypes"("col_id"),
	PRIMARY KEY("col_id" AUTOINCREMENT),
	FOREIGN KEY("col_course") REFERENCES "tbl_Courses"("col_id"),
	FOREIGN KEY("col_teacher") REFERENCES "tbl_Teachers"("col_id")
);
CREATE TABLE IF NOT EXISTS "tbl_Attendance" (
	"col_studentid"	integer,
	"col_classid"	integer,
	FOREIGN KEY("col_studentid") REFERENCES "tbl_Students"("col_id"),
	FOREIGN KEY("col_classid") REFERENCES "tbl_Classes"("col_id")
);
CREATE TABLE IF NOT EXISTS "tbl_Subscriptions" (
	"col_studentid"	integer,
	"col_courseid"	integer,
	FOREIGN KEY("col_courseid") REFERENCES "tbl_Courses"("col_id"),
	FOREIGN KEY("col_studentid") REFERENCES "tbl_Students"("col_id")
);
CREATE TABLE IF NOT EXISTS "tbl_CourseMaterialTypes" (
	"col_id"	integer UNIQUE,
	"col_coursematerialtype"	varchar(30),
	PRIMARY KEY("col_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "tbl_CourseMaterial" (
	"col_id"	integer UNIQUE,
	"col_coursematerialtype"	integer,
	"col_course"	integer,
	"col_date_added"	datetime,
	"col_date_changed" datetime,
	"col_url"	varchar(30),
	"col_fileextension" varchar(30),
	FOREIGN KEY("col_coursematerialtype") REFERENCES "tbl_CourseMaterialTypes"("col_id"),
	PRIMARY KEY("col_id" AUTOINCREMENT),
	FOREIGN KEY("col_course") REFERENCES "tbl_Courses"("col_id")
);

CREATE TABLE IF NOT EXISTS "tbl_CourseMaterialUsedInClass" (
	"col_class_id" integer,
	"col_course_material_id" integer,
	FOREIGN KEY("col_course_material_id") REFERENCES "tbl_CourseMaterial"("col_id"),
	FOREIGN KEY("col_class_id") REFERENCES "tbl_Classes"("col_id")
);	

CREATE TABLE IF NOT EXISTS "tbl_Recordings" (
	"col_id"	integer UNIQUE,
	"col_classid"	integer,
	"col_url"	varchar(30),
	"col_duration"	time,
	"col_classroom_id" integer,
	PRIMARY KEY("col_id" AUTOINCREMENT),
	FOREIGN KEY("col_classid") REFERENCES "tbl_Classes"("col_id"),
	FOREIGN KEY("col_classroom_id") REFERENCES "tbl_Classrooms"("col_id")
);
CREATE TABLE IF NOT EXISTS "tbl_Classrooms" (
	"col_id"	integer UNIQUE,
	PRIMARY KEY("col_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "tbl_ClassInClassroom" (
	"col_class_id"	integer,
	"col_classroom_id"	integer,
	FOREIGN KEY("col_class_id") REFERENCES "tbl_Classes"("col_id"),
	FOREIGN KEY("col_classroom_id") REFERENCES "tbl_Classrooms"("col_id")
);
CREATE TABLE IF NOT EXISTS "tbl_ColorCodes" (
	"col_id"	integer UNIQUE,
	"col_color"	varchar(30),
	"col_occupancy_change"	double,
	"col_restrictions" text,
	PRIMARY KEY("col_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "tbl_PhysicalClassrooms" (
	"col_id"	integer UNIQUE,
	"col_room_nr"	varchar(30),
	"col_location"	varchar(60),
	"col_classroom_id"	integer,
	"col_number_of_seats"	integer,
	"col_color_code"	integer,
	FOREIGN KEY("col_color_code") REFERENCES "tbl_ColorCodes"("col_id"),
	PRIMARY KEY("col_id" AUTOINCREMENT),
	FOREIGN KEY("col_classroom_id") REFERENCES "tbl_Classrooms"("col_id")
);
CREATE TABLE IF NOT EXISTS "tbl_OnlineClassrooms" (
	"col_id"	integer UNIQUE,
	"col_encoder"	varchar(30),
	"col_resolution"	varchar(30),
	"col_classroom_id"	integer,
	"col_bitrate"       varchar(30),
	PRIMARY KEY("col_id" AUTOINCREMENT),
	FOREIGN KEY("col_classroom_id") REFERENCES "tbl_Classrooms"("col_id")
);
CREATE TABLE IF NOT EXISTS "tbl_ZoomMeeting" (
	"col_id" integer UNIQUE,
	"col_meeting_id" varchar(30),
	"col_url"	varchar(255),
	"col_online_classroom"	integer,
	PRIMARY KEY("col_id"),
	FOREIGN KEY("col_online_classroom") REFERENCES "tbl_OnlineClassrooms"("col_id")
);
CREATE TABLE IF NOT EXISTS "tbl_PanoptoRecording" (
	"col_id"	integer UNIQUE,
	"col_url"	varchar(255),
	"col_notes" text,
	"col_online_classroom"	integer,
	PRIMARY KEY("col_id" AUTOINCREMENT),
	FOREIGN KEY("col_online_classroom") REFERENCES "tbl_OnlineClassrooms"("col_id")
);
CREATE TABLE IF NOT EXISTS "tbl_PanoptoRecordingAnnotation" (
	"col_id"	integer UNIQUE,
	"col_timestamp_in_recording"	time,
	"col_created_by_student"	integer,
	"col_panopto_recording"	integer,
	"col_text"	text,
	FOREIGN KEY("col_created_by_student") REFERENCES "tbl_Students"("col_id"),
	PRIMARY KEY("col_id" AUTOINCREMENT),
	FOREIGN KEY("col_panopto_recording") REFERENCES "tbl_PanoptoRecording"("col_id")
);
CREATE TABLE IF NOT EXISTS "tbl_PanoptoRecordingBookmark" (
	"col_id"	integer UNIQUE,
	"col_timestamp_in_recording"	time,
	"col_text"	text,
	"col_panopto_recording"	integer,
	PRIMARY KEY("col_id" AUTOINCREMENT),
	FOREIGN KEY("col_panopto_recording") REFERENCES "tbl_PanoptoRecording"("col_id")
);
CREATE TABLE IF NOT EXISTS "tbl_MicrosoftTeamsMeeting" (
	"col_id"	integer UNIQUE,
	"col_session_url"	varchar(255),
	"col_chat_history"	text,
	"col_online_classroom"	integer,
	PRIMARY KEY("col_id" AUTOINCREMENT),
	FOREIGN KEY("col_online_classroom") REFERENCES "tbl_OnlineClassrooms"("col_id")
);
CREATE TABLE IF NOT EXISTS "tbl_BigBlueButtonMeeting" (
	"col_id"	integer UNIQUE,
	"col_chat_history"	text,
	"col_online_classroom"	integer,
	FOREIGN KEY("col_online_classroom") REFERENCES "tbl_OnlineClassrooms"("col_id"),
	PRIMARY KEY("col_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "tbl_BreakoutRoom" (
	"col_id"	integer UNIQUE,
	"col_startdate"	datetime,
	"col_duration"	time,
	"col_bigbluebutton_meeting"	int,
	FOREIGN KEY("col_bigbluebutton_meeting") REFERENCES "tbl_BigBlueButtonMeeting"("col_id"),
	PRIMARY KEY("col_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "tbl_BreakoutRoomParticipation" (
	"col_person_id"	integer,
	"col_breakout_room"	integer,
	FOREIGN KEY("col_person_id") REFERENCES "tbl_Persons"("col_id"),
	FOREIGN KEY("col_breakout_room") REFERENCES "tbl_BreakoutRoom"("col_id")
);
CREATE TABLE IF NOT EXISTS "tbl_Poll" (
	"col_id"	integer UNIQUE,
	"col_bigbluebutton_meeting"	integer,
	"col_question"	varchar(255),
	PRIMARY KEY("col_id" AUTOINCREMENT),
	FOREIGN KEY("col_bigbluebutton_meeting") REFERENCES "tbl_BigBlueButtonMeeting"("col_id")
);
CREATE TABLE IF NOT EXISTS "tbl_PollOptions" (
	"col_id"	integer UNIQUE,
	"col_poll"	integer,
	"col_text"	varchar(255),
	FOREIGN KEY("col_poll") REFERENCES "tbl_Poll"("col_id"),
	PRIMARY KEY("col_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "tbl_PollVotes" (
	"col_id"	integer UNIQUE,
	"col_poll_option"	integer,
	"col_student"	integer,
	PRIMARY KEY("col_id" AUTOINCREMENT),
	FOREIGN KEY("col_student") REFERENCES "tbl_Students"("col_id"),
	FOREIGN KEY("col_poll_option") REFERENCES "tbl_PollOptions"("col_id")
);
INSERT INTO "tbl_Persons" VALUES (1,'Denis','Carnier','deniscarnier','denis.carnier@virtualuniversity.be');
INSERT INTO "tbl_Persons" VALUES (2,'Gwij','Grenié','gwijgrenie','gwij.grenie@virtualuniversity.be');
INSERT INTO "tbl_Persons" VALUES (3,'Robrecht','Blancquaert','robrechtblancquaert','robrecht.blancquaert@virtualuniversity.be');
INSERT INTO "tbl_Persons" VALUES (4,'Dieter','Vandesande','dietervandesande','dieter.vandesande@virtualuniversity.be');
INSERT INTO "tbl_Persons" VALUES (5,'Maxim','Van de Wynckel','maximvandewynckel','maxim.vandewynckel@virtualuniversity.be');
INSERT INTO "tbl_Persons" VALUES (6,'Younes','Zeboudj','youneszeboudj','younes.zeboudj@virtualuniversity.be');
INSERT INTO "tbl_Persons" VALUES (7,'Bart','Bogaerts','bartbogaerts','Bart.Bogaerts@virtualuniversity.be');
INSERT INTO "tbl_Persons" VALUES (8,'Bas','Ketsman','basketsman','Bas.Ketsman@virtualuniversity.be');
INSERT INTO "tbl_Persons" VALUES (9,'Jan','Janssens','janjanssens','Jan.Janssens@external-university.be');
INSERT INTO "tbl_Persons" VALUES (10,'Willem','Willems','willemwillems','Willem.Willems@virtualuniversity.be');
INSERT INTO "tbl_TeacherTypes" VALUES (1,'Professor');
INSERT INTO "tbl_TeacherTypes" VALUES (2,'TeachingAssistant');
INSERT INTO "tbl_TeacherTypes" VALUES (3,'GuestLecturer');
INSERT INTO "tbl_Teachers" VALUES (1,'1',2,5);
INSERT INTO "tbl_Teachers" VALUES (2,'2',2,6);
INSERT INTO "tbl_Teachers" VALUES (3,'3',1,7);
INSERT INTO "tbl_Teachers" VALUES (4,'4',1,8);
INSERT INTO "tbl_Teachers" VALUES (5,'5_ex',3,9);
INSERT INTO "tbl_Teachers" VALUES (6,'6',1,10);
INSERT INTO "tbl_Students" VALUES (1,'0565691',1);
INSERT INTO "tbl_Students" VALUES (2,'0565692',2);
INSERT INTO "tbl_Students" VALUES (3,'0565693',3);
INSERT INTO "tbl_Students" VALUES (4,'0565694',4);
INSERT INTO "tbl_Courses" VALUES (1,'4014887FNR','Open Information Systems',6,'https://caliweb.cumulus.vub.ac.be/?page=course-offer&id=005033&anchor=1&target=pr&year=2021&language=nl&output=html');
INSERT INTO "tbl_Courses" VALUES (2,'4016441ENR','Image and Video Technology',3,'https://caliweb.cumulus.vub.ac.be/?page=course-offer&id=007041&anchor=1&target=pr&year=2021&language=nl&output=html');
INSERT INTO "tbl_Courses" VALUES (3,'4013056FNR','Functional Programming',6,'https://caliweb.cumulus.vub.ac.be/?page=course-offer&id=010169&anchor=2&target=pr&year=2021&language=nl&output=html');
INSERT INTO "tbl_Classtypes" VALUES (1,'LabSession');
INSERT INTO "tbl_Classtypes" VALUES (2,'Lecture');
INSERT INTO "tbl_Classtypes" VALUES (3,'QnASession');
INSERT INTO "tbl_Classes" VALUES (1,'2020-09-30T10:00:00','2020-09-30T12:00:00',1,'RDF/RDFS',2,4);
INSERT INTO "tbl_Classes" VALUES (2,'2020-10-10T10:00:00','2020-10-10T12:00:00',1,'Description Logics',2,3);
INSERT INTO "tbl_Classes" VALUES (3,'2020-10-13T10:00:00','2020-10-13T12:00:00',2,'Description Logics',3,3);
INSERT INTO "tbl_Classes" VALUES (4,'2020-11-10T15:00:00','2020-11-10T17:00:00',1,'Description Logics',1,2);
INSERT INTO "tbl_Classes" VALUES (5,'2020-11-10T15:00:00','2020-11-10T17:00:00',2,'Entropy encoding',1,1);
INSERT INTO "tbl_Classes" VALUES (6,'2020-12-02T10:00:00','2020-12-02T12:00:00',1,'Semantic Web',2,5);
INSERT INTO "tbl_Attendance" VALUES (1,2);
INSERT INTO "tbl_Attendance" VALUES (2,2);
INSERT INTO "tbl_Attendance" VALUES (3,2);
INSERT INTO "tbl_Attendance" VALUES (4,2);
INSERT INTO "tbl_Attendance" VALUES (2,1);
INSERT INTO "tbl_Attendance" VALUES (2,2);
INSERT INTO "tbl_Attendance" VALUES (2,3);
INSERT INTO "tbl_Attendance" VALUES (2,4);
INSERT INTO "tbl_Attendance" VALUES (2,5);
INSERT INTO "tbl_Attendance" VALUES (1,5);
INSERT INTO "tbl_Attendance" VALUES (3,5);
INSERT INTO "tbl_Attendance" VALUES (4,5);
INSERT INTO "tbl_Subscriptions" VALUES (4,2);
INSERT INTO "tbl_CourseMaterialTypes" VALUES (1,'code');
INSERT INTO "tbl_CourseMaterialTypes" VALUES (2,'handouts');
INSERT INTO "tbl_CourseMaterialTypes" VALUES (3,'book');
INSERT INTO "tbl_CourseMaterialTypes" VALUES (4,'exercises');
INSERT INTO "tbl_CourseMaterial" VALUES (2,3,1,'2020-09-23T11:14:01.043','2020-09-23T11:14:01.043','https://canvas.vub.be/courses/19277/files/564304?module_item_id=99457', '.pdf');
INSERT INTO "tbl_CourseMaterial" VALUES (1,3,1,'2020-09-16T10:20:05.123','2020-09-16T10:20:05.123','https://canvas.vub.be/courses/19277/files/545504?module_item_id=99452', '.pdf');
INSERT INTO "tbl_CourseMaterial" VALUES (3,3,1,'2020-10-01T17:51:51.246','2020-10-01T17:51:51.246','https://canvas.vub.be/courses/19277/files/597928?module_item_id=109612', '.pdf');
INSERT INTO "tbl_CourseMaterial" VALUES (4,2,1,'2020-09-16T16:43:51.246','2020-09-25T12:55:51.246','https://canvas.vub.be/courses/19277/files/559249?module_item_id=96569', '.pdf');
INSERT INTO "tbl_CourseMaterial" VALUES (5,1,1,'2020-09-16T16:45:16.439','2020-09-16T16:45:16.439','https://canvas.vub.be/courses/19277/files/606913?module_item_id=99451', '.pdf');
INSERT INTO "tbl_CourseMaterial" VALUES (6,1,3,'2020-10-01T16:45:16.439','2020-10-01T16:45:16.439','https://canvas.vub.be/files/569076/download?download_frd=1', '.pdf');
INSERT INTO "tbl_CourseMaterial" VALUES (7,1,3,'2020-10-08T16:45:16.439','2020-11-09T16:45:16.439','https://canvas.vub.be/files/580072/download?download_frd=1', '.pdf');
INSERT INTO "tbl_CourseMaterial" VALUES (8,1,3,'2020-10-15T16:45:16.439','2020-10-15T16:45:16.439','https://canvas.vub.be/files/589883/download?download_frd=1', '.pdf');
INSERT INTO "tbl_CourseMaterial" VALUES (9,1,2,'2020-10-22T16:45:16.439','2020-10-22T16:45:16.439','https://canvas.vub.be/files/556561/download?download_frd=1', '.pdf');
INSERT INTO "tbl_CourseMaterial" VALUES (10,1,2,'2020-10-29T16:45:16.439','2020-10-29T16:45:16.439','https://canvas.vub.be/files/558373/download?download_frd=1', '.pdf');
INSERT INTO "tbl_CourseMaterial" VALUES (11,1,2,'2020-11-04T16:45:16.439','2020-11-04T16:45:16.439','https://canvas.vub.be/files/579563/download?download_frd=1', '.pdf');
INSERT INTO "tbl_CourseMaterialUsedInClass" VALUES (1,3);
INSERT INTO "tbl_CourseMaterialUsedInClass" VALUES (3,11);
INSERT INTO "tbl_CourseMaterialUsedInClass" VALUES (1,5);
INSERT INTO "tbl_CourseMaterialUsedInClass" VALUES (4,5);
INSERT INTO "tbl_Recordings" VALUES (1,5,'http://youtube.com/exampleurl01','02:16:43', 2);
INSERT INTO "tbl_Recordings" VALUES (2,1,'http://youtube.com/exampleurl02','01:54:43', 6);
INSERT INTO "tbl_Classrooms" VALUES (1);
INSERT INTO "tbl_Classrooms" VALUES (2);
INSERT INTO "tbl_Classrooms" VALUES (3);
INSERT INTO "tbl_Classrooms" VALUES (4);
INSERT INTO "tbl_Classrooms" VALUES (5);
INSERT INTO "tbl_Classrooms" VALUES (6);
INSERT INTO "tbl_ClassInClassroom" VALUES (1,1);
INSERT INTO "tbl_ClassInClassroom" VALUES (2,2);
INSERT INTO "tbl_ClassInClassroom" VALUES (3,3);
INSERT INTO "tbl_ClassInClassroom" VALUES (4,4);
INSERT INTO "tbl_ClassInClassroom" VALUES (5,5);
INSERT INTO "tbl_ClassInClassroom" VALUES (1,6);
INSERT INTO "tbl_ColorCodes" VALUES (1,'green',1.0, "Everything is possible.");
INSERT INTO "tbl_ColorCodes" VALUES (2,'yellow',0.5, "A mask is obligated in class.");
INSERT INTO "tbl_ColorCodes" VALUES (3,'red',0.2, "A mask is obligated on the whole campus.");
INSERT INTO "tbl_PhysicalClassrooms" VALUES (1,'E.007','Gebouw E, gelijksvloers', 6,64,3);
INSERT INTO "tbl_OnlineClassrooms" VALUES (5,'x265','1080x720', 1,'10 MB/s');
INSERT INTO "tbl_OnlineClassrooms" VALUES (1,'x264','1080x720', 2, '12 MB/s');
INSERT INTO "tbl_OnlineClassrooms" VALUES (2,'x264','1920x1080', 3, '7 MB/s');
INSERT INTO "tbl_OnlineClassrooms" VALUES (3,'x264','1080x720', 4,'9 MB/s');
INSERT INTO "tbl_OnlineClassrooms" VALUES (4,'x264','1080x720',5,'12 MB/s');
INSERT INTO "tbl_ZoomMeeting" VALUES (1, '439-4005054-11', 'htttp://zoom.com/exampleur101',1);
INSERT INTO "tbl_ZoomMeeting" VALUES (2, '234-3256432-26', 'htttp://zoom.com/exampleur102',5);
INSERT INTO "tbl_PanoptoRecording" VALUES (1,'https://vub.cloud.panopto.eu/Panopto/Pages/Viewer.aspx?id=575fea71-91e1-4335-8ee8-ac9300ab0c7d','Deze recording heeft geen notes',2);
INSERT INTO "tbl_PanoptoRecordingAnnotation" VALUES (1,'00:04:00.000',1,1,'Test timestamp');
INSERT INTO "tbl_PanoptoRecordingBookmark" VALUES (1,'00:01:00.000','start lecture',1);
INSERT INTO "tbl_MicrosoftTeamsMeeting" VALUES (1,'http://teams.com/exampleurl',"Dieter says: Hello! Denis says: Hi there!",3);
INSERT INTO "tbl_BigBlueButtonMeeting" VALUES (1,"Gwij says: Goodmorning. Robrecht says: Goodmorning!",4);
INSERT INTO "tbl_BreakoutRoom" VALUES (1,'2020-11-10 15:04:16','00:16:14',1);
INSERT INTO "tbl_BreakoutRoom" VALUES (2,'2020-11-10 15:04:16','00:16:14',1);
INSERT INTO "tbl_BreakoutRoom" VALUES (3,'2020-11-10 15:04:16','00:16:14',1);
INSERT INTO "tbl_BreakoutRoom" VALUES (4,'2020-11-10 15:45:16','00:59:01',1);
INSERT INTO "tbl_BreakoutRoom" VALUES (5,'2020-11-10 15:45:16','00:59:01',1);
INSERT INTO "tbl_BreakoutRoomParticipation" VALUES (2,1);
INSERT INTO "tbl_BreakoutRoomParticipation" VALUES (1,1);
INSERT INTO "tbl_BreakoutRoomParticipation" VALUES (3,2);
INSERT INTO "tbl_BreakoutRoomParticipation" VALUES (4,2);
INSERT INTO "tbl_BreakoutRoomParticipation" VALUES (1,4);
INSERT INTO "tbl_BreakoutRoomParticipation" VALUES (2,4);
INSERT INTO "tbl_BreakoutRoomParticipation" VALUES (3,4);
INSERT INTO "tbl_BreakoutRoomParticipation" VALUES (4,4);
INSERT INTO "tbl_BreakoutRoomParticipation" VALUES (5,4);
INSERT INTO "tbl_BreakoutRoomParticipation" VALUES (5,2);
INSERT INTO "tbl_BreakoutRoomParticipation" VALUES (7,4);
INSERT INTO "tbl_BreakoutRoomParticipation" VALUES (8,4);

INSERT INTO "tbl_Poll" VALUES (1,1,'What exercise are you on?');
INSERT INTO "tbl_Poll" VALUES (2,1,'Do you want a break?');
INSERT INTO "tbl_PollOptions" VALUES (1,1,'Exercise 1');
INSERT INTO "tbl_PollOptions" VALUES (2,1,'Exercise 2');
INSERT INTO "tbl_PollOptions" VALUES (3,1,'Exercise 3');
INSERT INTO "tbl_PollOptions" VALUES (4,1,'Exercise 4');
INSERT INTO "tbl_PollOptions" VALUES (5,2,'Yes');
INSERT INTO "tbl_PollOptions" VALUES (6,2,'No');
INSERT INTO "tbl_PollVotes" VALUES (1,1,2);
INSERT INTO "tbl_PollVotes" VALUES (2,1,1);
INSERT INTO "tbl_PollVotes" VALUES (3,2,3);
INSERT INTO "tbl_PollVotes" VALUES (4,4,4);
INSERT INTO "tbl_PollVotes" VALUES (5,5,1);
INSERT INTO "tbl_PollVotes" VALUES (6,5,2);
INSERT INTO "tbl_PollVotes" VALUES (7,6,3);
COMMIT;
