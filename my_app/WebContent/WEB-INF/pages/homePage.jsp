<%@ include file="/common/taglibs.jsp"%>
<%@ page contentType="text/html;charset=utf-8"%>

<head>

<script type="text/javascript">
	$(document)
			.ready(
					function() {
						var url = "http://localhost:8080/my_app/jsonusers";
						// prepare the data
						var source = {
							dataType : "json",
							type : "POST",
							dataFields : [ {
								name : 'id',
								type : 'string'
							}, {
								name : 'username',
								type : 'string'
							}, {
								name : 'email',
								type : 'string'
							}, {
								name : 'phoneNumber',
								type : 'string'
							}, {
								name : 'firstName',
								type : 'string'
							}, {
								name : 'lastName',
								type : 'string'
							} , {
								name : 'action',
								type : 'string'
							} ],
							id : 'id',
							url : url,
							data : {
								featureClass : "P",
								style : "full",
								maxRows : 20,
								username : ""
							}
						};
						var dataAdapter = new $.jqx.dataAdapter(source);
						$("#dataTable").jqxDataTable({
							width : '100%',
							theme : 'arctic',
							pageable : true,
							pagerButtonsCount : 10,
							source : dataAdapter,
							columnsResize : true,
							columns : [ {
								text : 'username',
								dataField : 'username',
								width : 300
							}, {
								text : 'email',
								dataField : 'email',
								width : 300
							}, {
								text : 'phoneNumber',
								dataField : 'phoneNumber',
								width : 180
							}, {
								text : 'firstName',
								dataField : 'firstName',
								width : 120
							}, {
								text : 'lastName',
								dataField : 'lastName'
							} ]
						});
						/*             $("#findButton").on('click', function () {
						 source.data.username='aaaa';
						 dataAdapter.dataBind();
						 $("#events").find('span').remove();
						 $("#events").append('<span>Submit Button Clicked</span');
						 }); */
						$('#dataTable').on('pageChanged', function(event) {
							// event args.
							var args = event.args;
							// page num.
							var pageNum = args.pagenum;
							// old page num.
							var oldPageNum = args.oldpagenum;
							// page size.
							var pageSize = args.pagesize;

							alert(args + ' ' + pageNum);
						});
						$("#jqxToolBar")
								.jqxToolBar(
										{
											theme : 'arctic',
											width : "100%",
											height : 40,
											tools : " button | button | button | button",
											initTools : function(type, index,
													tool,
													menuToolIninitialization) {
												var icon_find = $("<span class='glyphicon glyphicon-search'> 查找</span>");
												var icon_add = $("<span class='glyphicon glyphicon-plus'> 新增   </span>");
												var icon_del = $("<span class='glyphicon glyphicon-minus'> 删除</span>");
												var icon_update = $("<span class='glyphicon glyphicon-edit'> 修改</span>");
												switch (index) {
												case 0:
													tool.append(icon_find)
													tool.on("click",function() {
																		$('#testForm').jqxValidator('validate');
																		source.data.username = 'bbbb';
																		dataAdapter.dataBind();
																				});
													break;
												case 1:
													tool.append(icon_add);
													tool.on("click",function() {
																		$("#editWin").jqxWindow('open');
																				});
													break;
												case 2:
													tool.append(icon_del);
													tool
															.on(
																	"click",
																	function() {
																		var selection = $(
																				"#dataTable")
																				.jqxDataTable(
																						'getSelection');
																		alert(selection[0].username);
																	});
													break;
												case 3:
													tool.append(icon_update);
													tool
															.on(
																	"click",
																	function() {
																		var selection = $(
																				"#dataTable")
																				.jqxDataTable(
																						'getSelection');
																		alert(selection[0].username);
																	});
													break;
												}
											}
										});

						// place others 
						/* 						$("#jqxPanel").jqxPanel({
						 width : '100%',
						 theme : 'arctic',
						 sizeMode: "wrap"
						 });

						 $("#ssnInput").jqxMaskedInput({
						 mask : '###-##-####',
						 width : 150,
						 height : 22
						 });
						 $("#phoneInput").jqxMaskedInput({
						 mask : '(###)###-####',
						 width : 150,
						 height : 22
						 });
						 $('.text-input').jqxInput({});
						 $('#birthInput').jqxDateTimeInput({
						 width : 150,
						 height : 22,
						 value : new Date(2014, 4, 1)
						 }); */
						// initialize validator.
						$('#testForm').jqxValidator({
							rules : [ {
								input : '#userInput',
								message : 'Username is required!',
								action : 'keyup, blur',
								rule : 'required'
							} ]
						});

						$("#editWin").jqxWindow({
							resizable : false,
							position : {
								left : $("#dataTable").offset().left + 175,
								top : $("#dataTable").offset().top - 35
							},
							width : 500,
							height : 240,
							autoOpen : false
						});
						$("#editWin").css('visibility', 'visible');
						$("#editToolbar")
								.jqxToolBar(
										{
											theme : 'arctic',
											width : "100%",
											height : 35,
											tools : " button | button ",
											initTools : function(type, index,
													tool,
													menuToolIninitialization) {
												var icon_save = $("<span class='glyphicon glyphicon-search'> 保存</span>");
												var icon_cancel = $("<span class='glyphicon glyphicon-plus'> 取消   </span>");
												switch (index) {
												case 0:
													tool.append(icon_save)
													tool.on("click",
															function() {
																//保存
																formData.data.username = $("#username").val();
																formData.data.email=$("#email").val();
																formData.data.phoneNumber=$("#phoneNumber").val();
																formData.data.firstName=$("#firstName").val();
																formData.data.lastName=$("#lastName").val();
																formAdapter.dataBind();
															});
													break;
												case 1:
													tool.append(icon_cancel);
													tool.on("click",
															function() {
																// 取消
																var selection = $("#dataTable").jqxDataTable('getSelection');
																alert(selection[0].username);
																dataAdapter = selection;
															});
													break;
												}
											}
										}); 
						//初始化输入框  $("#input").jqxInput({placeHolder: "Enter a Country", height: 25, width: 200, minLength: 1,  source: countries });
			//			$("#jqxInput").jqxInput({source: dataAdapter placeHolder: "Contact Name:", displayMember: "ContactName", 
				//									valueMember: "CompanyName", width: 200, height: 25});
            var formData = {
							dataType : "json",
							type : "POST",
							dataFields : [  {
								name : 'action',
								type : 'string'
							} ],
							id : 'id',
							url : url,
							data : {
								lastName : "",
								firstName : "",
								phoneNumber : "",
								email : "",
								username : ""
							}
						};
            var formAdapter = new $.jqx.dataAdapter(formData,{
                     loadComplete: function () {
                         // get data records.
                         var records = dataAdapter.records;
                         // get the length of the records array.
                         var length = records.length;
                         alert("ok");
                     },
                     loadError: function (jqXHR, status, error) {
                     },
                     beforeLoadComplete: function (records) {
                     }
            });
						$("#username").jqxInput({ height: 25, width: 200, minLength: 1});
						$("#email").jqxInput({   height: 25, width: 200, minLength: 1});
						$("#phoneNumber").jqxInput({ height: 25, width: 200, minLength: 1});
						$("#firstName").jqxInput({   height: 25, width: 200, minLength: 1});
						$("#lastName").jqxInput({   height: 25, width: 200, minLength: 1});
						
						
						
					});
</script>
<style type="text/css">
.text-input {
	height: 21px;
	width: 150px;
}

.register-table {
	margin-top: 10px;
	margin-left: 20px;
	margin-bottom: 10px;
}

.register-table td, .register-table tr {
	margin: 0px;
	padding: 2px;
	border-spacing: 0px;
	border-collapse: collapse;
	font-family: Verdana;
	font-size: 12px;
}

h3 {
	display: inline-block;
	margin: 0px;
}
</style>
</head>
<body class='default'>


	<div id="jqxToolBar"></div>
	<div id="jqxPanel">
		<div>
			<form id="testForm" action="./">
				<table class="register-table">
					<tr>
						<td>Username:</td>
						<td><input type="text" id="userInput" class="text-input" /></td>
						<td>Real name:</td>
						<td><input type="text" id="realNameInput" class="text-input" /></td>
					</tr>
				</table>
			</form>
		</div>
		<br>
	</div>
	<div id="dataTable"></div>
	<div id='events'></div>
	<div style="visibility: hidden;" id="editWin">
		<div>Edit Dialog</div>
		<div style="overflow: hidden;">
			<div id="editToolbar"></div>
			<table
				style="table-layout: fixed; margin-left: 30px; border-style: none; height: 160px">
				<tr>
					<td>Username:</td>
					<td><input type="text" id="username" class="text-input" /><input
						type="text" id="id" hidden /></td>
				</tr>
				<tr>
					<td>email:</td>
					<td><input type="text" id="email" class="text-input" /></td>
				</tr>
				<tr>
					<td>Phone NO.:</td>
					<td><input type="text" id="phoneNumber" class="text-input" /></td>
				</tr>
				<tr>
					<td>firstName:</td>
					<td><input type="text" id="firstName" class="text-input" /></td>
				</tr>
				<tr>
					<td>lastName:</td>
					<td><input type="text" id="lastName" class="text-input" /></td>
				</tr>
			</table>
			</form>
		</div>
</body>