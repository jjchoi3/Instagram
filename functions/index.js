const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp();

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
// exports.helloWorld = functions.https.onRequest((request, response) => {
//  response.send("Hello from Firebase!");
// });

exports.onCreateFollower = functions.firestore
  .document('/followers/{userId}/userFollowers/{followerId}')
  .onCreate(async (snapshot, context) => {

    console.log("Follower Created", snapshot.id);
    const userId = context.params.userId
    const followerId = context.params.followerId

    //Create followed user's posts reference
    const followedUserPostRef = admin.firestore().collection("myPosts").doc(userId).collection("userPosts");

    //Create following user's timeline reference
    const timelinePostsRef = admin.firestore().collection("timeline").doc(followerId).collection("timelinePosts");

    //Get followed users myPosts
    const querySnapshot = await followedUserPostRef.get();

    //Add each user post to following user's timelinePostsRef
    querySnapshot.forEach(doc =>{
      if(doc.exists){
        const postId = doc.id
        const postData = doc.data();
        timelinePostsRef.doc(postId).set(postData);
      }
    });

  });


exports.onDeleteFollower = functions.firestore
    .document('/followers/{userId}/userFollowers/{followerId}')
    .onDelete(async (snapshot, context) => {

      console.log("Follower Deleted", snapshot.id);
      const userId = context.params.userId
      const followerId = context.params.followerId

      const timelinePostsRef = admin.firestore().collection("timeline").doc(followerId).collection("timelinePosts").where("ownerId", "==", userId);

      const querySnapshot = await timelinePostsRef.get();

      querySnapshot.forEach(doc =>{
        if(doc.exists){
          doc.ref.delete()
        }
      });

    });

    exports.onCreatePost = functions.firestore
        .document('/myPosts/{userId}/userPosts/{postId}')
        .onCreate(async (snapshot, context) => {

          const postData = snapshot.data()
          const userId = context.params.userId
          const postId = context.params.postId

          const timelinePostsRef = admin.firestore().collection("followers").doc(userId).collection("userFollowers")

          const querySnapshot = await userFollowersRef.get();

          querySnapshot.forEach(doc =>{
            const followerId = doc.id;
            admin.firestore().collection("timeline").doc(followerId).collection("timelinePosts").doc(postId).set(postData)
          });

        });
