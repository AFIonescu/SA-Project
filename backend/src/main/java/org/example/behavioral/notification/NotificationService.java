package org.example.behavioral.notification;

import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Slf4j
@Service
public class NotificationService {
    private List<Observer> observers = new ArrayList<>();

    public void addObserver(Observer observer) {
        observers.add(observer);
        log.debug("NotificationService: Observer added");
    }

    public void notifyObservers(String message) {
        log.info("NotificationService: Notifying {} observers", observers.size());
        for (Observer observer : observers) {
            observer.update(message);
        }
    }
}
