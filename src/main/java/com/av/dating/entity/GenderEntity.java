package com.av.dating.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(schema = "main", name = "genders")
public class GenderEntity {

    @Id
    @Column(name = "language")
    private Long language;

    @Id
    @Column(name = "gender")
    private String gender;

    @Column(name = "gender_name")
    private String genderName;

}
