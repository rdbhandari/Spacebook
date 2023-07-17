# Spacebook Documentation

![Static Badge](https://img.shields.io/badge/Frontend:-ffffff) 
![HTML5 Badge](https://img.shields.io/badge/HTML5-E34F26?logo=html5&logoColor=fff&style=flat) ![CSS3 Badge](https://img.shields.io/badge/CSS3-1572B6?logo=css3&logoColor=fff&style=flat) ![JavaScript Badge](https://img.shields.io/badge/JavaScript-F7DF1E?logo=javascript&logoColor=000&style=flat) ![Bootstrap Badge](https://img.shields.io/badge/Bootstrap-7952B3?logo=bootstrap&logoColor=fff&style=flat)

![Static Badge](https://img.shields.io/badge/Backend:-ffffff) 
![MySQL Badge](https://img.shields.io/badge/Java-ED8B00?logo=openjdk&style=flat)  ![Apache Tomcat Badge 9.0](https://img.shields.io/badge/Apache%20Tomcat-9.0-F8DC759?logo=apachetomcat&logoColor=000&style=flat) ![MySQL Badge](https://img.shields.io/badge/MySQL-4479A1?logo=mysql&logoColor=fff&style=flat)





## Features

### <center>a. Client Features</center> 
**CRUD USER**
1. User can register  on the site to perform following operations.
2. Registered user can login & logout.
3. User can see own and other profile also.
4. User can edit their profile details. 
5. User can delete their profile.

**CRUD POST**
1. User can create post with image and text.
2. User can read post of their follower in home page.
3. User can see own post at their profile section.
4. User can edit own post at their profile section.
5. User can delete own post at their profile section.
6. User can report at other user’s post visible to them.

**LIKE**
1. User can like a post or remove like from liked post.

**CRUD COMMENT**
1. User can read comment in a post.
2. User can make comment in a post.
3. User can edit comment in post.
4. User can delete comment in post.

**FOLLOW USER**
1. User can send follow request to specific user.
2. User can accept or cancel follow request
3. User can unfollow to specific user.
4. User can block/unblock a user
5. User can remove user from follower and follows list

**OTHERS**
1. Infinite scrolling: Post will shown on chunk by chunk
2. Data Validation : Input fields checks before contacting with server.

### <center>b. Admin Features</center> 
**Admin Login -** **Email:** admin@spacebook.com 	**Password: ** "admin"

**POST MONITOR**
1. Admin can check and delete or ignore reported post

**USER MONITOR**
1. Check all user details
2. Admin can ban a user for input time.

## Output

## Database
### <center> ER Diagram </center>
IMG
### <center> SQL Query To Create Database</center>
```sql
CREATE DATABASE spacebook; USE spacebook; 
CREATE TABLE `user` ( `u_id` INT(10) AUTO_INCREMENT, `u_email` VARCHAR(255), `u_name` VARCHAR(50), `u_img` VARCHAR(100), `u_dob` DATE, `u_gender` VARCHAR(6), `u_pswd` VARCHAR(256), `u_sts` TINYINT(1), `u_banfor` DATETIME, PRIMARY KEY (`u_id`) ); 
CREATE TABLE `post` ( `p_id` INT(10) AUTO_INCREMENT, `p_desc` VARCHAR(1000), `p_img` VARCHAR(200), `p_time` DATETIME DEFAULT CURRENT_TIMESTAMP, `u_id` int(10), PRIMARY KEY (`p_id`), FOREIGN KEY (u_id) REFERENCES user(u_id) ); 
CREATE TABLE `likes` ( `p_id` INT(10), `u_id` INT(10), FOREIGN KEY (u_id) REFERENCES user(u_id), FOREIGN KEY (p_id) REFERENCES post(p_id) ); 
CREATE TABLE `comments` ( `c_id` INT(10) AUTO_INCREMENT, `p_id` INT(10), `u_id` INT(10), `c_desc` VARCHAR(200), `c_time` DATETIME DEFAULT CURRENT_TIMESTAMP , PRIMARY KEY (`c_id`), FOREIGN KEY (u_id) REFERENCES user(u_id), FOREIGN KEY (p_id) REFERENCES post(p_id) ); 
CREATE TABLE `reports` ( `p_id` INT(10), `u_id` int(10), FOREIGN KEY (u_id) REFERENCES user(u_id), FOREIGN KEY (p_id) REFERENCES post(p_id) ); 
CREATE TABLE `follows` ( `u1_id` INT(10), `u2_id` INT(10), `f_sts` TINYINT(1), FOREIGN KEY (u1_id) REFERENCES user(u_id), FOREIGN KEY (u2_id) REFERENCES user(u_id) );
```

***Use Given SQL DUMP (spacebook.sql) With Following Login Password***

### <center> Login Passwords </center>
**Client Users**
1. **Email:** John@Wick.Com 	**Password:** "11111111"
2. **Email:** Mahendra@Singh.Dhoni 	**Password:** "11111111"
3. **Email:** Elon@Reeve.Musk 	**Password:** "11111111"
4. **Email:** Rahul@Deb.Bhandari 	**Password:** "11111111"

**Admin**
1. **Email:** admin@spacebook.com 	**Password:** "admin"


