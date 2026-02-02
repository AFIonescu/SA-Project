package org.example.behavioral.notification;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

@Slf4j
@Component
public class SMSNotification implements Observer {

    @Override
    public void update(String message) {
        log.info("SMSNotification: Sending SMS - {}", message);
    }
}
