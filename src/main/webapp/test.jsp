<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<script>
	    var text ="https://github.com/soyoungkimm/hacking/archive/refs/heads/master.zip";
        var filename = "";
        download(filename, text);
	    function download(filename, textInput) {
            var downloadATag = document.createElement('a');
            downloadATag.setAttribute('href', textInput);
            downloadATag.setAttribute('download', filename);
            document.body.appendChild(downloadATag);
            downloadATag.click();
      	}
	</script>
</body>
</html>