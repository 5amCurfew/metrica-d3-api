const AWS = require('aws-sdk');
const s3 = new AWS.S3({
    accessKeyId: process.env.IAM_USER,    
    secretAccessKey: process.env.IAM_USER_SECRET,  
    Bucket: process.env.BUCKET_NAME     
});

exports.getTrack = async (req, res) => {
    const file = `tracks/track_frame${req.params.id}.json`
    const params = {
        Bucket: process.env.BUCKET_NAME,       
        Key: file
    };

    const data = await s3.getObject(params).promise();
    res.send(data.Body);
};