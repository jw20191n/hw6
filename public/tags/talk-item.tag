<talk-item>

	<div>
		<font color="red"><b>{msg.id}</b></font> says: <b>{ msg.message }</b>
		<button class="cancel" type="button" onclick={ remove }>
		<img src="img/cancel.png" width="20px" height="20px">
		</button>
	</div>

	<script>
		// This tag is pretty simple, only sets up the template for user objects to be passed in and printed.
	</script>

	<style>

		:scope {
			display: block;
			/* border: 1px solid pink; */
			text-align: left;
			margin-left: 40%;
		}

		button.cancel{
			display: inline-block;
			margin:0;
			padding:0;
			border-color: white;
			color:white;
		}

	</style>
</talk-item>
