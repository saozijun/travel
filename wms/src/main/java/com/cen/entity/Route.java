package com.cen.entity;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * <p>
 * 
 * </p>
 *
 * @author volcano
 * @since 2025-03-21
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("sys_route")
public class Route implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    private String name;

    private Integer scenicId;

    private String routeData;

    private String imageUrl;

    private String description;

    private LocalDateTime createdAt;

    private LocalDateTime updatedAt;
}
