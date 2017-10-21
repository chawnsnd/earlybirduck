create database earlybirduck default character set utf8;

create user 'chawnsnd'@'localhost' identified by 'tw161379';
create user 'chawnsnd'@'%' identified by 'tw161379';

grant all privileges on earlybirduck.* to 'chawnsnd'@'localhost';
grant all privileges on earlybirduck.* to 'chawnsnd'@'%';

create table earlybirduck.member(
	memberid varchar(50) primary key,
	name varchar(50) not null,
	password varchar(10) not null,
	regdate datetime not null
) engine=InnoDB default character set = utf8;

select * from earlybirduck.member;

create table earlybirduck.mission(
	memberid varchar(50) not null,
	year int not null,
	month int not null,
	day int not null,
	week char(3) not null,
	firstmission time,
	secondmission time,
	thirdmission time,
	primary key(memberid,year,month,day),
	foreign key(memberid) references member(memberid)
) engine=InnoDB default character set = utf8;

alter table mission change firstmission firstmission time;
alter table mission change secondmission secondmission time;
alter table mission change thirdmission thirdmission time;
alter table mission change week week char(3);
alter table member change password password varchar(20);

alter table mission add constraint foreign key(memberid)
references member(memberid) on delete cascade on update cascade;

create table article (
    article_no int auto_increment primary key,
    writer_id varchar(50) not null,
    writer_name varchar(50) not null,
    title varchar(255) not null,
    regdate datetime not null,
    moddate datetime not null,
    read_cnt int
) engine=InnoDB default character set = utf8;

create table article_content (
    article_no int primary key,
    content text
) engine=InnoDB default character set = utf8;

alter table mission add penalty int;
alter table mission add chk varchar(5);

select * from mission;


create table comment(
	comment_no int auto_increment primary key,
	commenter_id varchar(50) not null,
	commenter_name varchar(50) not null,
	comment text,
	regdate datetime not null
) engine=InnoDB default character set =utf8;

alter table comment add article_no int;
alter table comment add constraint foreign key(article_no)
references article(article_no) on delete cascade on update cascade;
alter table article_content add constraint foreign key(article_no)
references article(article_no) on delete cascade on update cascade;

insert into comment (comment_no, commenter_id, commenter_name, comment, regdate, article_no) values (1, 'chawnsnd', '가이름','2번글 댓글입니다.',now(), 2);

select * from comment;

select count(*) as count from comment group by article_no = 2
