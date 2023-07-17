<%@ include file="private/templates/login_check.jsp"%>

<%@ include file="private/library/db_conn.jsp"%>

<%@ include file="private/templates/header.jsp"%>
<%@ include file="private/templates/navbar.jsp"%>

<div class="row justify-content-center wrapper">
	<h2 class="text-center text-secondary">Friends Zone</h2>
	<div class="col-md-5">
		<div class="accordion" id="accordionPanelsStayOpenExample">

			<div class="accordion-item">

				<h2 class="accordion-header" id="sec-youmayknow-header">
					<button class="accordion-button" type="button"
						data-bs-toggle="collapse" data-bs-target="#sec-youmayknow"
						aria-expanded="true" aria-controls="sec-youmayknow">People
						You may Know</button>
				</h2>

				<!-- PEOPLE YOU MAY KNOW -->

				<div id="sec-youmayknow" class="accordion-collapse collapse show"
					aria-labelledby="sec-youmayknow-header" >
					<div class="accordion-body" id="sec-youmayknow-body">
					<%
						PreparedStatement pstmt_pymk = null;
						try {
							pstmt_pymk = con.prepareStatement(
							"SELECT u_id, u_name, u_img FROM user WHERE u_id NOT IN ( SELECT u2_id FROM follows WHERE u1_id = ? UNION SELECT u_id FROM user WHERE u_id IN ( 0 , ?) ) ORDER BY RAND() LIMIT 3;");
							pstmt_pymk.setString(1, session.getAttribute("u_id").toString());
							pstmt_pymk.setString(2, session.getAttribute("u_id").toString());

							ResultSet rs = pstmt_pymk.executeQuery();
							String result = "";

							while (rs.next()) {
					%>
							<div class="d-flex justify-content-between mb-2 align-items-center">
								<a
									href="http://localhost:8080/Spacebook/profile.jsp?id=<%=rs.getString("u_id")%>" class="text-secondary">
									<img
									src="http://localhost:8080/Spacebook/img/<%=rs.getString("u_img")%>"
									alt="user-image" class="user-image" height="40px" width="40px"><b>&nbsp;<%=rs.getString("u_name")%></b>
								</a>
								<button type="button" class="btn btn-info btn-sm"
									onclick="send_follow_request(<%=rs.getString("u_id")%>)"
									style="height: 30px;">Follow</button>
							</div>
					<%
							}
		
						} catch (Exception e) {
								System.out.print(e);
						}
					%>
					</div>
				</div>
			</div>


			<div class="accordion-item">

				<h2 class="accordion-header" id="sec-frnd-rqst-header">
					<button class="accordion-button collapsed" type="button"
						data-bs-toggle="collapse" data-bs-target="#sec-frnd-rqst"
						aria-expanded="true" aria-controls="sec-frnd-rqst">Follow
						Requests</button>
				</h2>

				<!-- REQUESTS -->

				<div id="sec-frnd-rqst" class="accordion-collapse collapse"
					aria-labelledby="sec-frnd-rqst-header">
					<div class="accordion-body" id="sec-frnd-rqst-body">
						<%
						PreparedStatement pstmt_rsqt = null;
						try {
							pstmt_rsqt = con.prepareStatement(
							"SELECT u_id, u_name, u_img FROM user LEFT JOIN follows ON user.u_id = follows.u1_id WHERE follows.u2_id = ? AND f_sts = 0;");
							pstmt_rsqt.setString(1, session.getAttribute("u_id").toString());

							ResultSet rs = pstmt_rsqt.executeQuery();
							String result = "";

							while (rs.next()) {
						%>
						<div
							class="d-flex justify-content-between my-1 align-items-center">
							<a
								href="http://localhost:8080/Spacebook/profile.jsp?id=<%=rs.getString("u_id")%>">
								<img
								src="http://localhost:8080/Spacebook/img/<%=rs.getString("u_img")%>"
								alt="user-image" class="user-image" height="40px" width="40px"><b>&nbsp;<%=rs.getString("u_name")%></b>
							</a>
							<button type="button" class="btn btn-success btn-sm"
								style="height: 30px;"
								onclick="accept_request(<%=rs.getString("u_id")%>)">Accept</button>
						</div>


						<%
						}

						} catch (Exception e) {
						System.out.print(e);
						}
						%>

					</div>
				</div>
			</div>



			<!-- FOLLOWER -->

			<div class="accordion-item">

				<h2 class="accordion-header" id="sec-follower-header">
					<button class="accordion-button collapsed" type="button"
						data-bs-toggle="collapse" data-bs-target="#sec-follower"
						aria-expanded="true" aria-controls="sec-follower">Followers</button>
				</h2>

				<div id="sec-follower" class="accordion-collapse collapse"
					aria-labelledby="sec-follower-header">
					<div class="accordion-body" id="	">
						<%
						PreparedStatement pstmt_flr = null;
						try {
							pstmt_flr = con.prepareStatement(
							"SELECT u_id, u_name, u_img FROM user LEFT JOIN follows ON user.u_id = follows.u1_id WHERE follows.u2_id = ? AND f_sts = 1;");
							pstmt_flr.setString(1, session.getAttribute("u_id").toString());

							ResultSet rs = pstmt_flr.executeQuery();
							String result = "";

							while (rs.next()) {
						%>
						<div
							class="d-flex justify-content-between my-1 align-items-center">
							<a
								href="http://localhost:8080/Spacebook/profile.jsp?id=<%=rs.getString("u_id")%>">
								<img
								src="http://localhost:8080/Spacebook/img/<%=rs.getString("u_img")%>"
								alt="user-image" class="user-image" height="40px" width="40px"><b>&nbsp;<%=rs.getString("u_name")%></b>
							</a>
							<button type="button" class="btn btn-danger btn-sm"
								style="height: 30px;"
								onclick="remove_follower(<%=rs.getString("u_id")%>)">Remove</button>
						</div>

						<%
						}

						} catch (Exception e) {
						System.out.print(e);
						}
						%>
					</div>
				</div>
			</div>


			<!-- FOLLOWS -->


			<div class="accordion-item">

				<h2 class="accordion-header" id="sec-follows-header">
					<button class="accordion-button collapsed" type="button"
						data-bs-toggle="collapse" data-bs-target="#sec-follows"
						aria-expanded="true" aria-controls="sec-follows">Follows</button>
				</h2>

				<div id="sec-follows" class="accordion-collapse collapse"
					aria-labelledby="sec-follows-header">
					<div class="accordion-body" id="sec-follows-body">
						<%
						PreparedStatement pstmt_fls = null;
						try {
							pstmt_fls = con.prepareStatement(
							"SELECT u_id, u_name, u_img FROM user LEFT JOIN follows ON user.u_id = follows.u2_id WHERE follows.u1_id = ? AND f_sts = 1;");
							pstmt_fls.setString(1, session.getAttribute("u_id").toString());

							ResultSet rs = pstmt_fls.executeQuery();
							String result = "";

							while (rs.next()) {
						%>
						<div
							class="d-flex justify-content-between my-1 align-items-center">
							<a
								href="http://localhost:8080/Spacebook/profile.jsp?id=<%=rs.getString("u_id")%>">
								<img
								src="http://localhost:8080/Spacebook/img/<%=rs.getString("u_img")%>"
								alt="user-image" class="user-image" height="40px" width="40px"><b>&nbsp;<%=rs.getString("u_name")%></b>
							</a>
							<button type="button" class="btn btn-danger btn-sm"
									onclick="unfollow(<%=rs.getString("u_id")%>)"
									style="height: 30px;">Unfollow</button>
						</div>


						<%
						}

						} catch (Exception e) {
						System.out.print(e);
						}
						%>
					</div>
				</div>
			</div>

		</div>
	</div>
</div>

<%@ include file="private/templates/footer.jsp"%>