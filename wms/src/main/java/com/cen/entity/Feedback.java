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
 * 景区反馈表
 * </p>
 *
 * @author volcano
 * @since 2025-03-24
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("sys_feedback")
public class Feedback implements Serializable {

    private static final long serialVersionUID = 1L;

    // 反馈ID
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    // 用户ID
    private Long userId;

    // 景区ID
    private Integer scenicId;

    // 反馈内容
    private String content;

    // 评分（1-5分）
    private Integer rate;

    // 创建时间
    private LocalDateTime createdAt;

    // 更新时间
    private LocalDateTime updatedAt;
}
