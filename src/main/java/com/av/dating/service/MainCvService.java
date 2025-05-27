package com.av.dating.service;

import com.av.dating.dto.MainCvDto;
import com.av.dating.entity.MainCvEntity;
import com.av.dating.repository.MainCvRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import java.util.List;
import java.util.stream.Collectors;

@Service
@RequiredArgsConstructor
public class MainCvService {

    private final MainCvRepository mainCvRepository;

    public List<MainCvDto> findAllCvs() {
        return mainCvRepository.findAll().stream()
            .map(this::convertToDto)
            .collect(Collectors.toList());
    }

    private MainCvDto convertToDto(MainCvEntity entity) {
        MainCvDto dto = new MainCvDto();
        dto.setUserId(entity.getUserId());
        dto.setAdNickname(entity.getAdNickname());
        return dto;
    }
}
