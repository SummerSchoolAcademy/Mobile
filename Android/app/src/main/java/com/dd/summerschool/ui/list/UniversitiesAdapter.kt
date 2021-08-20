package com.dd.summerschool.ui.list

import android.graphics.drawable.Drawable
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup
import android.widget.CheckBox
import android.widget.CompoundButton
import android.widget.ImageView
import android.widget.TextView
import androidx.recyclerview.widget.DiffUtil
import androidx.recyclerview.widget.ListAdapter
import androidx.recyclerview.widget.RecyclerView
import com.dd.summerschool.R
import com.dd.summerschool.databinding.ItemUniversityBinding
import com.dd.summerschool.ext.setImageFromAsset
import com.dd.summerschool.model.University
import java.io.IOException
import java.io.InputStream


class UniversitiesAdapter(
    private val listener: UniversityItemListener
) : ListAdapter<University, UniversitiesAdapter.UniversityViewHolder>(UNIVERSITY_COMPARATOR) {

    override fun onCreateViewHolder(parent: ViewGroup, viewType: Int): UniversityViewHolder {
        return UniversityViewHolder(
            ItemUniversityBinding.inflate(LayoutInflater.from(parent.context), parent, false)
        )
    }

    override fun onBindViewHolder(holder: UniversityViewHolder, position: Int) {
        val item = getItem(position)
        holder.bind(item)
    }

    inner class UniversityViewHolder(binding: ItemUniversityBinding) : RecyclerView.ViewHolder(binding.root) {
        private val nameView: TextView = binding.name
        private val yearView: TextView = binding.year
        private val cityView: TextView = binding.city
        private val imageView: ImageView = binding.image
        private val favCheck: CheckBox = binding.checkFavourite

        fun bind(item: University) {
            //1. set data to views
            nameView.text = item.name
            yearView.text = itemView.resources.getString(R.string.university_item_year_format, item.year)
            cityView.text = itemView.resources.getString(R.string.university_item_city_format, item.city)
            favCheck.isChecked = item.favourite
            imageView.setImageFromAsset(item.image)

            //2. set listeners on views
            itemView.setOnClickListener(object : View.OnClickListener {
                override fun onClick(v: View?) {
                    listener.onItemTap(item.id)
                }
            })
            favCheck.setOnCheckedChangeListener(object: CompoundButton.OnCheckedChangeListener{
                override fun onCheckedChanged(buttonView: CompoundButton?, isChecked: Boolean) {
                    listener.onItemFavourite(item.id, isChecked)
                }
            })
        }
    }

    companion object {
        private val UNIVERSITY_COMPARATOR = object: DiffUtil.ItemCallback<University>() {
            override fun areItemsTheSame(oldItem: University, newItem: University): Boolean =
                oldItem.id == newItem.id

            override fun areContentsTheSame(oldItem: University, newItem: University): Boolean =
                oldItem == newItem

        }
    }
}