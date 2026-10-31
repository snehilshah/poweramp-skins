package io.github.poweramp.skins.liquidglass;

import android.app.Activity;
import android.content.Intent;
import android.os.Bundle;
import android.view.Gravity;
import android.widget.Button;
import android.widget.LinearLayout;
import android.widget.TextView;
import android.widget.Toast;

/** Minimal skin app screen: explains the skin and opens Poweramp so it can load the skin. */
public class SkinInfoActivity extends Activity {
    private static final String POWERAMP_PACKAGE = "com.maxmpz.audioplayer";

    @Override
    protected void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);

        int pad = (int) (24 * getResources().getDisplayMetrics().density);
        LinearLayout root = new LinearLayout(this);
        root.setOrientation(LinearLayout.VERTICAL);
        root.setGravity(Gravity.CENTER);
        root.setPadding(pad, pad, pad, pad);

        TextView title = new TextView(this);
        title.setText(R.string.lg_skin_name);
        title.setTextSize(28);
        title.setGravity(Gravity.CENTER);

        TextView body = new TextView(this);
        body.setText(R.string.app_info);
        body.setGravity(Gravity.CENTER);
        body.setPadding(0, pad / 2, 0, pad);

        Button open = new Button(this);
        open.setText(R.string.open_poweramp);
        open.setOnClickListener(v -> {
            Intent intent = getPackageManager().getLaunchIntentForPackage(POWERAMP_PACKAGE);
            if (intent == null) {
                Toast.makeText(this, R.string.poweramp_missing, Toast.LENGTH_LONG).show();
            } else {
                startActivity(intent);
            }
        });

        root.addView(title);
        root.addView(body);
        root.addView(open);
        setContentView(root);
    }
}
