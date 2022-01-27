package kr.festi.androidfirebasesample;

import android.os.Handler;
import android.os.Looper;
import android.util.Log;
import android.widget.Toast;

import com.google.firebase.messaging.FirebaseMessagingService;
import com.google.firebase.messaging.RemoteMessage;


public class MyFirebaseMessagingService extends FirebaseMessagingService {
    static final String TAG = MyFirebaseMessagingService.class.getName();

    @Override
    public void onMessageReceived(RemoteMessage remoteMessage) {
        super.onMessageReceived(remoteMessage);

        if (remoteMessage.getData().size() > 0) {
            Log.d(TAG, "FCM Data Message : " + remoteMessage.getData());
        }

        if (remoteMessage.getNotification() != null) {
            final String messageBody = remoteMessage.getNotification().getBody();

            Log.d(TAG, "FCM Notification Message Body : " + messageBody);

            Handler handler = new Handler(Looper.getMainLooper());
            handler.post(new Runnable() {
                @Override
                public void run() {
                    Toast.makeText(getApplicationContext(), messageBody, Toast.LENGTH_SHORT).show();
                }
            });
        }
    }
}