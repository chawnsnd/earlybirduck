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

select * from mission;

delete from mission;

update mission set firstmission = curtime() where memberid='chawnsnd' and year=2017 and month=9 and day=24;

select year, month, day, week, firstmission, secondmission, thirdmission from mission where memberid='chawnsnd'







