package com.cen.entity;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.math.BigDecimal;
import java.time.LocalDateTime;

/**
 * <p>
 * 
 * </p>
 *
 * @author volcano
 * @since 2025-03-20
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("sys_scenic")
public class Scenic implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    private String name;

    private String address;

    private String openingHours;

    private BigDecimal ticketPrice;

    private String description;

    private String contactPhone;

    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

    private String imageUrl;

    private String locations;
}
