for a in dealii-base-system dealii-external-libraries dealii; do 
    cd $a; 
    docker build -t heltai/$a . 
    nohup docker push heltai/$a &
    cd ..
done
