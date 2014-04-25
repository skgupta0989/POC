var restify = require('restify');
var mongojs = require('mongojs');

var ip_addr = '127.0.0.1';
var port = '8080';

var server = restify.createServer({
	name : "myapp"
});


server.use(restify.queryParser());
server.use(restify.bodyParser());
server.use(restify.CORS());

var connection_string = '127.0.0.1:27017/myapp';
var db = mongojs(connection_string, ['myapp']);
var user = db.collection("user");

var posts = db.collection("posts");

user.ensureIndex( { "emailId": 3 }, { unique: true } );

var PATH = '/user'
server.get({path : PATH , version : '0.0.1'} , findAllUser);
server.post({path : PATH +'/:login' , version : '0.0.1'} , findUser);
server.post({path : PATH , version: '0.0.1'} ,register);
server.del({path : PATH +'/:userId' , version: '0.0.1'} ,deleteUser);

var PATH1 = '/posts'

server.get({path : PATH1 , version : '0.0.1'} , findAllPosts);
server.post({path : PATH1 +'/blogPost', version: '0.0.1'} ,blogInfo);
server.post({path : PATH1 , version : '0.0.1'} , findUserPosts);
server.post({path : PATH1 +'/commentBlog' , version : '0.0.1'} , commentUpdate);
server.post({path : PATH1 +'/updateLike', version : '0.0.1'} , updateNumberLikes);
server.del({path : PATH1 +'/:userId' , version: '0.0.1'} ,deletePost);






function findAllUser(req, res , next){
    res.setHeader('Access-Control-Allow-Origin','*');
    user.find().sort({postedOn : -1} , function(err , success){
        console.log('Response success1 '+success);
        console.log('Response error1 '+err);
        if(success){
            res.send(200 , success);
            return next();
        }else{
            return next(err);
        }
 
    });
 
}
 
function findUser(req, res , next){
    res.setHeader('Access-Control-Allow-Origin','*');
    console.log(req.params.email);
    console.log(req.params.password);

    console.log('user collection'+user);
    user.findOne({ $and: [{ emailId: req.params.email },{ password: req.params.password}]},function(err,success){
  
        console.log('Response success 2'+success);
        //console.log("hi"+success.name);
        console.log('Response error2 '+err);
        if(success!==null){
            res.send(200 , success);
            return next();
        }
        else{
            return next(err);
        }
        
    });
}
 
function register(req , res , next){
    var info = {};
    info.name = req.params.name;
    info.phonenumber = req.params.phonenumber;
    info.emailId = req.params.emailId;
    info.password = req.params.password;
    

    res.setHeader('Access-Control-Allow-Origin','*');
 
    user.save(info , function(err , success){
        console.log('Response success 3'+success);
        console.log('Response error 3'+err);
        if(success){
            res.send(201 , info);
            return next();
        }else{
            return next(err);
        }
    });
}



function findAllPosts(req, res , next){

    
    res.setHeader('Access-Control-Allow-Origin','*');

    console.log('Response success ');
    posts.find().sort({postedOn : -1} , function(err , success){
        console.log('Response success 4'+success);
        console.log('Response error 4'+err);
        if(success){
            res.send(200 , success);
            return next();
        }else{
            return next(err);
        }
 
    });
 
}

function commentUpdate(req , res , next){
   
   
    console.log("hi");
    
    console.log('Response '+req.params.comment);
     console.log('Response '+req.params.id);

     res.setHeader('Access-Control-Allow-Origin','*');
    posts.update( {_id : mongojs.ObjectId(req.params.id)},{ $push: { comments:req.params.comment} },function(err , success){
   
        console.log('Response success comment 5 '+success);
        console.log('Response error 5'+err);
        if(success){
            res.send(201, success);
            return next();
        }else{
            return next(err);
        }
    });
}


 
function blogInfo(req , res , next){
    var data = {};
    data.userId = req.params.userId;
    data.name = req.params.name;
    data.blog = req.params.blog;
    data.like = req.params.like;
    data.buttonName = req.params.buttonName;
    data.comments = req.params.comments;
   
 
    res.setHeader('Access-Control-Allow-Origin','*');
 
    posts.save(data , function(err , success){
        console.log('Response success 6 '+success);
        console.log('Response error 6'+err);
        if(success){
            res.send(201 , data);
            return next();
        }else{
            return next(err);
        }
    });
}



function findUserPosts(req, res , next){
    
     res.setHeader('Access-Control-Allow-Origin','*');
     posts.find({userId : req.params.uid}, function(err , success){
        console.log('Response success 7'+success);
        console.log('Response error 7'+err);
        if(success){
            res.send(200 , success);
            return next();
        }else{
            return next(err);
        }
 
    });
}


function updateNumberLikes(req, res , next){
    
      console.log("hi");
    
    console.log('Response '+req.params.like);
     console.log('Response '+req.params.id);

     res.setHeader('Access-Control-Allow-Origin','*');
    posts.update( {_id : mongojs.ObjectId(req.params.id)},{ $set: { like:req.params.like,buttonName:req.params.buttonName} },function(err , success){
   
        console.log('Response success comment 11 '+success);
        console.log('Response error 11'+err);
        if(success){
            res.send(201, success);
            return next();
        }else{
            return next(err);
        }
    });
}

function deleteUser(req , res , next){
    res.setHeader('Access-Control-Allow-Origin','*');
    user.remove({_id:mongojs.ObjectId(req.params.userId)} , function(err , success){
        console.log('Response success 8'+success);
        console.log('Response error 8'+err);
        if(success){
            res.send(204);
            return next();      
        } else{
            return next(err);
        }
    })
 
}


function deletePost(req , res , next){
    res.setHeader('Access-Control-Allow-Origin','*');
    posts.remove({_id:mongojs.ObjectId(req.params.userId)} , function(err , success){
        console.log('Response success 9'+success);
        console.log('Response error 9'+err);
        if(success){
            res.send(204);
            return next();      
        } else{
            return next(err);
        }
    })
 
}


server.listen(port,ip_addr,function(){
	console.log('%s listening at %s',server.name,server.url)
});
