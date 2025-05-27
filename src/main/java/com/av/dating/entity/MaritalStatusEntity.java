package com.av.dating.entity;

import jakarta.persistence.Column;
import jakarta.persistence.Entity;
import jakarta.persistence.Id;
import jakarta.persistence.JoinColumn;
import jakarta.persistence.JoinColumns;
import jakarta.persistence.ManyToOne;
import jakarta.persistence.Table;
import lombok.Data;

@Data
@Entity
@Table(schema = "main", name = "marital_status")
public class MaritalStatusEntity {

    @Id
    @Column(name = "marital_status_id")
    private Long maritalStatusId;

    @Id
    @ManyToOne
    @JoinColumns({
        @JoinColumn(name = "language", referencedColumnName = "language"),
        @JoinColumn(name = "gender", referencedColumnName = "gender")
    })
    private GenderEntity gender;

    @Column(name = "status_name")
    private String statusName;

}
