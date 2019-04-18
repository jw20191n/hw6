<talk-app>

  <div class="login" if={!currentUser}>
		<p>Thanks for visiting. Please proceed to Google Authentication</p>
		<button type="button" onclick={ logIn }>Login</button>
	</div>

	<div if={currentUser}>
	<div class="login">
		<p>Welcome to the admin section.</p>
		<button type="button" onclick={ logOut}>Log Out</button>
	</div>
</div>

<br>
  <input type="text" ref="userInput" placeholder="Name the pet">
  <input type="text" ref="msgInput" placeholder="Type in your message" value="">
	<button type="button" onclick={ saveMsg }>Teach the pet to talk</button>

  <div class="order">
    <p>order data by</p>
    <select ref="order" value="" onchange={ orderResults }>
      <option value="default">default</option>
      <option value="username">Username</option>
    </select>
  </div>

  <div class="talk-list">
    	<talk-item each={ msg in messages }></talk-item>
  </div>

	<script>

    var tag = this;
    var messagesRef = rootRef.child('messages');
    var userRef = rootRef.child('messageByUser');

    this.userID = "Pet";
    this.messages = [];
    this.users = [];

    this.setUser = function(){
      this.userID = this.refs.userInput.value;
    }

    this.saveMsg = function(){
      var key = messagesRef.push().key;
      console.log(key);

      var msg = {
        id: this.refs.userInput.value,
        message:this.refs.msgInput.value
      };



      messagesRef.push(msg);
    }

    messagesRef.on('value', function(snap){
			let dataAsObj = snap.val();


			var tempData = [];


			for (key in dataAsObj) {
				tempData.push(dataAsObj[key]);
			}

			tag.messages = tempData;


			tag.update();
		});


    remove = function (){
      console.log("this.id", this.id);
      //remember how we pushed the unique key as a property of each meme?
      var key = this.id;
      messagesRef.child(key).remove();
    }

//orderResult

orderResults() {
      //1. get order value
      let order = this.refs.order.value;
      // console.log("order", order);

      let orderResult = messagesRef;
      console.log("messagesRef", messagesRef);

      // if order is selected as funnies, then order messages by child propoerty funness if order is selected as caption, then order messages by child propoerty caption if order is elected as default, no need to reorder at specifically
      if(order=="username"){
        orderResult = orderResult.orderByChild("id");
      }else if(order=="default"){

      }

      orderResult.once('value', function (snap) {
        // let rawdata = snap.val(); console.log("datafromfb", datafromfb);
        let tempData = [];

        snap.forEach(function (child) {
          tempData.push(child.val()); // NOW THE CHILDREN PRINT IN ORDER
        });

        tag.messages = tempData;

        tag.update();
        observable.trigger('updateMessages', tempData);
      });
    }
//Authentication

    // firebase.auth().currentUser will always reflect the current authenticated user state. Gives a user object if logged in. Gives null if logged out.
    this.user = firebase.auth().currentUser;
    //
    // // AUTHENTICATION LISTENER Once we code this, we have a "live" listener that is constantly listening for whether the user is logged in or not. It will fire the callback if it "hears" a login, or logout.


    //sign-in with google
    this.logIn = function () {
      console.log("logging in...");
      var provider = new firebase.auth.GoogleAuthProvider();
      user.signInWithPopup(provider);
    }

    //sign-out
    this.logOut = function () {
      console.log("logging out...");
      user.signOut();
    }

    // sign-in Listener
    user.onAuthStateChanged(function(userObj) {
      if (userObj) {
        currentUser = firebase.auth().currentUser;
      } else {
        currentUser = null;
      }
      tag.update();
    });

    user.onAuthStateChanged(function (userObj) {
      tag.currentUser = firebase.auth().currentUser;
      console.log("on stage change: this.currentUser", this.currentUser);
      tag.update();
    });
	</script>

	<style>
		:scope {
			display:  block;
      margin:auto;
			height: 10%;
			width: 100%;
      padding:20px;
      text-align: center;
		}

    button{
      text-align: left;
    }

		.talk-list {
			margin-top: 20px;
		}
	</style>

</talk-app>
