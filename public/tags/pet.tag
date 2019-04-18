<pet>
  <img src="img/{ petImage }.gif">


  <div>
    <div class="bar intimacy">
      <div style="width:{ intimacy }%;">&nbsp;</div>
    </div>
    <p>Intimacy: { intimacy }</p>
  </div>


  <button onclick={ pat }>Pat</button>
  <button onclick={ hit }>Hit</button>


  <script>
    //make a copy of my pet object and call it that
    var that  = this;

    //initial state
    this.intimacy = 50;
    this.petImage = "neutral";

    //tell DOM window to increase hunger every three second
    //console.log(that);
    window.setInterval(function(){
      that.decIntimacy();
      console.log("wait");
      that.update();
      that.checkStatus();
      <!-- console.log(this); -->
    }, 3000);


    decIntimacy() {

      this.intimacy = this.intimacy - 10 < 0 ? 0 : this.intimacy - 10;
    }

    incIntimacy() {
      console.log(this.intimacy);
      this.intimacy = this.intimacy + 10 > 100 ? 100 : this.intimacy + 10;
    }

    checkStatus() {
      if (this.intimacy >= 70){
        this.petImage = "happy";
      } else if (this.intimacy <= 30){
        this.petImage = "sad";
      }else{
        this.petImage = "neutral";
      }
    }

    pat(e) {
      this.incIntimacy();
      this.checkStatus();
    }

    hit(e) {
      this.decIntimacy();
      this.checkStatus();
    }
  </script>

  <style>
  :scope{
    margin:auto;
  }

  img{
    weight:auto;
    height:200px;
  }

  </style>
</pet>
