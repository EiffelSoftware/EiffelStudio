<html>
<head>
<title>Info</title>
</head>
<body>

<pre>
Table


<table>
{foreach from="$users" item="user"}
   <tr>
      <td>{$user.name/}</td>
	   <td>{$user.phone/}</td>
   </tr>
{/foreach}
</table>

</body>
</html>