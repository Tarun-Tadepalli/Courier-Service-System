package com.klef.ep.models;

import javax.persistence.PrePersist;
import java.util.Random;

public class ParcelListener {

    @PrePersist
    public void generateAwbNoAndLrn(Parcel parcel) {
        if (parcel.getAwbNo() == null) {
            parcel.setAwbNo(generateAwbNo());
        }
        if (parcel.getLrn() == null) {
            parcel.setLrn(generateLrn());
        }
    }

    private String generateAwbNo() {
        Random random = new Random();
        int airlinePrefix = 100 + random.nextInt(900);
        int serialNumber = 1000000 + random.nextInt(9000000);
        int checkDigit = serialNumber % 7; 
        return String.format("%03d-%07d%d", airlinePrefix, serialNumber, checkDigit);
    }

    private String generateLrn() {
        return "LRN" + System.currentTimeMillis();
    }
}
