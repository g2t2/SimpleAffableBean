/**
 * BSD 3-Clause License
 *
 * Copyright (C) 2018 Steven Atkinson <steven@nowucca.com>
 * All rights reserved.
 *
 * Redistribution and use in source and binary forms, with or without
 * modification, are permitted provided that the following conditions are met:
 *
 * * Redistributions of source code must retain the above copyright notice, this
 *   list of conditions and the following disclaimer.
 *
 * * Redistributions in binary form must reproduce the above copyright notice,
 *   this list of conditions and the following disclaimer in the documentation
 *   and/or other materials provided with the distribution.
 *
 * * Neither the name of the copyright holder nor the names of its
 *   contributors may be used to endorse or promote products derived from
 *   this software without specific prior written permission.
 *
 * THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 * AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 * IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 * DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
 * FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 * DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 * SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 * CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 * OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 * OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */
package business.category;

import business.GuavaUtils;
import business.SimpleAffableDbException;
import com.google.common.cache.LoadingCache;
import com.google.common.collect.Maps;
import java.util.Collection;

/**
 */
public class CategoryDaoGuava implements CategoryDao {

    private CategoryDao origin;

    private LoadingCache<Long, Category> cache;

    @SuppressWarnings("ConstantConditions")
    public CategoryDaoGuava(CategoryDao originCategoryDao) {
        this.origin = originCategoryDao;
        cache = GuavaUtils.makeCache((k)->origin.findByCategoryId(k));
        bulkload();
    }

    public void bulkload() {
        // Bulk-fill the cache at startup time and periodically
        cache.putAll(Maps.uniqueIndex(origin.findAll(), Category::getCategoryId));
    }


    @Override
    public Category findByCategoryId(long categoryId) {
        try {
            return cache.get(categoryId);
        } catch (Exception e) {
            throw new SimpleAffableDbException("Encountered problem loading category id "+categoryId+" into cache", e);
        }
    }

    @Override
    public Collection<Category> findAll() {
        return cache.asMap().values();
    }

}
