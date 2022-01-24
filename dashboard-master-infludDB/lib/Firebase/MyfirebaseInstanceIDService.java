public class MyFirebaseMessagingService extends FirebaseMessagingService {
    @Override
    public void onMessageReceived(RemoteMessage remoteMessage) {

        Log.d(Constants.Companion.getLOG_TAG(), remoteMessage.getFrom());

        if (remoteMessage.getData().size() > 0) {
            Log.d(Constants.Companion.getLOG_TAG(), "Message data payload: " + remoteMessage.getData());

            handleNow();
        }


        if (remoteMessage.getNotification() != null) {
            Log.d(Constants.Companion.getLOG_TAG(), "Message Notification Body: " + remoteMessage.getNotification().getBody());
        }
    }

    private void scheduleJob() {

        FirebaseJobDispatcher dispatcher = new FirebaseJobDispatcher(new GooglePlayDriver(this));
        Job myJob = dispatcher.newJobBuilder()
                .setService(SGJobService.class)
                .setTag("my-job-tag")
                .build();
        dispatcher.schedule(myJob);
    }

    private void handleNow() {
        Log.d(Constants.Companion.getLOG_TAG(), "Short lived task is done.");
    }

}
