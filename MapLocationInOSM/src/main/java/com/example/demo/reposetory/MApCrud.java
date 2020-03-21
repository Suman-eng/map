package com.example.demo.reposetory;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.example.demo.entity.MapEntity;

@Repository
public interface MApCrud extends JpaRepository<MapEntity,Integer> {

}
