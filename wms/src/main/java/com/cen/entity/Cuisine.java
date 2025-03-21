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
@TableName("sys_cuisine")
public class Cuisine implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    private String name;

    private Integer scenicId;

    private BigDecimal price;

    private String description;

    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;

    private String imageUrl;
}
