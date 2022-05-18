const { Socket } = require("dgram");
const express = require("express");
const http = require("http");
var uniqid = require("uniqid");

const app = express();
const port = process.env.PORT || 3000;

var server = http.createServer(app);

var io = require("socket.io")(server);

//middlewawre
app.use(express.json());

var pollsList = [];

io.on("connection", (Socket) => {
  console.log("connected");
  io.emit("initstate",pollsList);
  Socket.on("createRoom", ({ question,pollsQuestion }) => {
      const uniqueId = uniqid();
   
      
        pollsList.push({ "pollname": question, "uid": uniqueId,"pollsQuestion":pollsQuestion});
      

        io.emit("createRoomSuccess",pollsList)
  });

  Socket.on("updateCheckBoxData",({uid,index})=>{
        
        pollsList.map(({uid:muid ,pollsQuestion:mdata},i)=>{
         
          if(muid===uid){
              mdata[index]["pollPercentage"]+=1;
          }
        })
        console.log(pollsList)
        Socket.emit("updateListListner",pollsList)
  })


  
});

app.get("/", function (req, res) {
  res.send("we are at the root route of our server");
});

server.listen(port, "0.0.0.0", () => {
  console.log("Server started and running on port " + port);
});
