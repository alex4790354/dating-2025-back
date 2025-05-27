package com.av.dating.conroller;

import com.av.dating.dto.MainCvDto;
import com.av.dating.service.MainCvService;
import java.util.List;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RequiredArgsConstructor
@RestController
@RequestMapping("find")
public class MainCvController {

    private final MainCvService mainCvService;
    @GetMapping("cv")
    public List<MainCvDto> findCv() {
        return mainCvService.findAllCvs();
    }

}
