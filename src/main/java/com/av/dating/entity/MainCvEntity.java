package com.av.dating.entity;

import jakarta.persistence.*;
import lombok.Data;

@Data
@Entity
@Table(schema = "main", name = "main_cv")
public class MainCvEntity {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "user_id")
    private Long userId;

    @Column(name = "language", nullable = false, length = 3)
    private String language;

    @Column(name = "gender", nullable = false, length = 3)
    private String gender;

    @Column(name = "city_id", nullable = false)
    private Integer cityId;

    /*@Column(name = "date_of_birth", nullable = false)
    private LocalDate dateOfBirth;*/

    @Column(name = "ad_nickname", nullable = false)
    private String adNickname;

    @Column(name = "cv_text", nullable = false)
    private String cvText;

    @Column(name = "marital_status_id", nullable = false)
    private Integer maritalStatusId;

    /*@Column(name = "latitude", nullable = false, precision = 9, scale = 6)
    private BigDecimal latitude;

    @Column(name = "longitude", nullable = false, precision = 9, scale = 6)
    private BigDecimal longitude;*/

}
